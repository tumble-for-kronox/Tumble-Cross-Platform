import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/notifications/builders/notification_service_builder.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/schedule_model_and_courses.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

part 'schedule_view_state.dart';

class ScheduleViewCubit extends Cubit<ScheduleViewState> {
  ScheduleViewCubit()
      : super(const ScheduleViewState(
          status: ScheduleViewStatus.LOADING,
          listOfDays: null,
          listOfWeeks: null,
          listViewToTopButtonVisible: false,
          message: null,
          scheduleModelAndCourses: null,
        )) {
    _init();
  }

  final _cacheAndInteractionService = getIt<CacheRepository>();
  final _notificationBuilder = NotificationServiceBuilder();
  final _notificationService = getIt<NotificationRepository>();
  final _databaseService = getIt<DatabaseRepository>();
  final _preferenceService = getIt<PreferenceRepository>();
  final ScrollController _listViewScrollController = ScrollController();

  ScrollController get controller => _listViewScrollController;
  bool get hasBookMarkedSchedules => getIt<PreferenceRepository>().bookmarkIds!.isNotEmpty;
  bool get notificationCheck => getIt<PreferenceRepository>().allowedNotifications == null;
  bool get toTopButtonVisible =>
      _listViewScrollController.hasClients ? _listViewScrollController.offset >= 1000 : false;

  Future<void> _init() async {
    log(name: 'schedule_view_cubit', 'Fetching cache ...');
    await getCachedSchedules();
    _listViewScrollController.addListener((setScrollController));
  }

  @override
  Future<void> close() {
    _listViewScrollController.dispose();
    return super.close();
  }

  Future<void> getCachedSchedules() async {
    final currentScheduleIds = _preferenceService.bookmarkIds;
    List<ScheduleModelAndCourses> listOfScheduleModelAndCourses = [];
    List<List<Day>> matrixListOfDays = [];
    emit(state.copyWith(displayedListItems: [], listOfDays: []));
    if (currentScheduleIds != null) {
      for (String? scheduleId in currentScheduleIds) {
        final bool userHasBookmarks = _preferenceService.userHasBookmarks;

        final bool? toggledToBeVisible = _preferenceService.bookmarkVisible(scheduleId);

        if (scheduleId != null && userHasBookmarks) {
          if (toggledToBeVisible != null && toggledToBeVisible) {
            final ScheduleOrProgrammeResponse apiResponse = await _cacheAndInteractionService.findSchedule(scheduleId);

            switch (apiResponse.status) {
              case ScheduleOrProgrammeStatus.FETCHED:
              case ScheduleOrProgrammeStatus.CACHED:
                ScheduleModel currentScheduleModel = apiResponse.data;
                if (currentScheduleModel.isNotPhonySchedule()) {
                  matrixListOfDays.add(currentScheduleModel.days);
                  listOfScheduleModelAndCourses.add(ScheduleModelAndCourses(
                      scheduleModel: currentScheduleModel,
                      courses: await _databaseService.getCachedCoursesFromId(currentScheduleModel.id)));
                }
                break;
              case ScheduleOrProgrammeStatus.ERROR:

                /// If an error occurs here, there is an underlying error in
                /// communication, the cache is broken, or the backend is down.
                emit(state.copyWith(status: ScheduleViewStatus.FETCH_ERROR));
                log(
                    name: 'schedule_view_cubit',
                    'Error in retrieveing schedule cache ..\nError on schedule: [$scheduleId');
                return;
              default:
                log(name: 'schedule_view_cubit', 'Unknown communication error occured on schedule: [$scheduleId]..');
                break;
            }
          }
        } else {
          emit(state.copyWith(status: ScheduleViewStatus.NO_VIEW));
        }
      }
      _setScheduleView(listOfScheduleModelAndCourses, matrixListOfDays);
    }
  }

  void _setScheduleView(List<ScheduleModelAndCourses> listOfScheduleModelAndCourses, List<List<Day>> matrixListOfDays) {
    if (listOfScheduleModelAndCourses.isNotEmpty) {
      final flattened = matrixListOfDays.expand((listOfDays) => listOfDays).toList();
      flattened.sort((prevDay, nextDay) => prevDay.isoString.compareTo(nextDay.isoString));

      var seen = <String>{};

      final listOfDays = groupBy(flattened, (Day day) => day.date)
          .entries
          .map((dayGrouper) => Day(
              name: dayGrouper.value[0].name,
              date: dayGrouper.value[0].date,
              isoString: dayGrouper.value[0].isoString,
              weekNumber: dayGrouper.value[0].weekNumber,
              events: dayGrouper.value.expand((day) => day.events).where((event) => seen.add(event.id)).toList()
                ..sort(((a, b) => a.from.compareTo(b.from)))))
          .toList();

      emit(state.copyWith(
        status: ScheduleViewStatus.POPULATED_VIEW,
        scheduleModelAndCourses: listOfScheduleModelAndCourses,
        listOfDays: listOfDays,
        listOfWeeks: listOfDays.splitToWeek(),
      ));
      log(name: 'schedule_view_cubit', 'Successfully updated entire schedule view. Exiting ..');
    } else {
      emit(state.copyWith(status: ScheduleViewStatus.NO_VIEW));
    }
  }

  setScrollController() async {
    if (_listViewScrollController.offset >= 1000) {
      emit(state.copyWith(listViewToTopButtonVisible: true));
    } else {
      emit(state.copyWith(listViewToTopButtonVisible: false));
    }
  }

  void scrollToTop() {
    _listViewScrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  setLoading() {
    emit(state.copyWith(status: ScheduleViewStatus.LOADING));
  }

  Color getColorForCourse(Event event) {
    try {
      return Color(state.scheduleModelAndCourses!
          .expand((scheduleModelAndCourses) => scheduleModelAndCourses!.courses)
          .firstWhere((courseUiModel) => courseUiModel!.courseId == event.course.id)!
          .color);
    } catch (e) {
      log('Attempted to find color for event, but it does not exist');
      return Colors.white;
    }
  } // Thank fuck

  Future<bool> createNotificationForEvent(Event event, BuildContext context) {
    return _notificationService.allowedNotifications().then((isAllowed) {
      if (isAllowed) {
        _notificationBuilder.buildOffsetNotification(
            id: event.id.encodeUniqueIdentifier(),
            channelKey: state.scheduleModelAndCourses!
                .firstWhere((scheduleModelAndCourses) => scheduleModelAndCourses!.courses
                    .any((courseUiModel) => courseUiModel!.courseId == event.course.id))!
                .scheduleModel
                .id,
            groupkey: event.course.id,
            title: event.title.capitalize(),
            body: event.course.englishName,
            date: event.from);

        log(name: 'schedule_view_cubit', 'Created notification for event "${event.title.capitalize()}"');

        showScaffoldMessage(context, S.scaffoldMessages.createdNotificationForEvent(event.title.capitalize()));

        return true;
      }
      log(name: 'schedule_view_cubit', 'No new notifications created. User not allowed');
      return false;
    });
  }

  Future<bool> createNotificationForCourse(Event event, BuildContext context) async {
    return _notificationService.allowedNotifications().then((isAllowed) {
      if (isAllowed) {
        List<Event> events = state.scheduleModelAndCourses!
            .expand((scheduleModelAndCourses) => scheduleModelAndCourses!.scheduleModel.days)
            .expand((Day day) => day.events) // Flatten nested list
            .toList()
            .where((Event eventInDefaultSchedule) => event.course.id == eventInDefaultSchedule.course.id)
            .toList();

        event.id.encodeUniqueIdentifier();

        int successfullyCreatedNotifications = 0;
        for (Event event in events) {
          if (event.from.isAfter(DateTime.now())) {
            _notificationBuilder.buildOffsetNotification(
                id: event.id.encodeUniqueIdentifier(),
                channelKey: state.scheduleModelAndCourses!
                    .firstWhere((scheduleModelAndCourses) => scheduleModelAndCourses!.courses
                        .any((courseUiModel) => courseUiModel!.courseId == event.course.id))!
                    .scheduleModel
                    .id,
                groupkey: event.course.id,
                title: event.title,
                body: event.course.englishName,
                date: event.from);
            successfullyCreatedNotifications++;
          }
        }
        log(
            name: 'schedule_view_cubit',
            'Created $successfullyCreatedNotifications new notifications for ${event.course}');

        showScaffoldMessage(
            context,
            S.scaffoldMessages
                .createdNotificationForCourse(event.course.englishName, successfullyCreatedNotifications));

        return true;
      }
      log(name: 'schedule_view_cubit', 'No new notifications created. Not allowed');
      return false;
    });
  }

  Future<bool> checkIfNotificationIsSetForEvent(Event event) => _notificationService.eventHasNotification(event);

  /// Returns true if course id is found in current list of notifications
  Future<bool> checkIfNotificationIsSetForCourse(Event event) => _notificationService.courseHasNotifications(event);

  Future<bool> cancelEventNotification(Event event) async {
    await _notificationService.cancelEventNotification(event);
    return !await checkIfNotificationIsSetForEvent(event);
  }

  /// Returns true if notification is still set for course
  Future<bool> cancelCourseNotifications(Event event) async {
    _notificationService.cancelCourseNotifications(event);
    return await checkIfNotificationIsSetForCourse(event);
  }

  void changeCourseColor(BuildContext context, Course course, Color color) {
    _databaseService
        .updateCourseInstance(CourseUiModel(
            scheduleId: state.scheduleModelAndCourses!
                .firstWhere((scheduleModelAndCourses) =>
                    scheduleModelAndCourses!.courses.any((courseUiModel) => courseUiModel!.courseId == course.id))!
                .scheduleModel
                .id,
            courseId: course.id,
            color: color.value))
        .then((value) {
      getCachedSchedules();
    });
  }

  Future<void> permissionRequest(bool value) async {
    if (value) {
      await _notificationService.getPermission();
    }
    await _preferenceService.setNotificationAllowed(value);
  }

  Future<void> forceRefreshAll() async {
    final visibleBookmarks = _preferenceService.visibleBookmarkIds;

    for (var bookmark in visibleBookmarks) {
      final ScheduleOrProgrammeResponse apiResponse =
          await _cacheAndInteractionService.updateSchedule(bookmark.scheduleId);

      switch (apiResponse.status) {
        case ScheduleOrProgrammeStatus.FETCHED:
          await _databaseService.update(apiResponse.data as ScheduleModel);
          break;
        default:
          break;
      }
    }
    await getCachedSchedules();
  }

  void cancelAllNotifications() => _notificationService.cancelAllNotifications();
}
