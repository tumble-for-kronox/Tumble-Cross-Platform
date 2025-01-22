import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/notifications/builders/notification_service_builder.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/schedule/utils/day_list_builder.dart';

part 'schedule_view_state.dart';

class ScheduleViewCubit extends Cubit<ScheduleViewState> {
  ScheduleViewCubit(KronoxUserModel? session)
      : super(const ScheduleViewState(
            status: ScheduleViewStatus.LOADING,
            listOfDays: null,
            listOfWeeks: null,
            listViewToTopButtonVisible: false,
            message: null,
            listOfScheduleModels: [])) {
    _init(session);
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

  Future<void> _init(KronoxUserModel? session) async {
    log(name: 'schedule_view_cubit', 'Fetching cache ...');
    await getCachedSchedules(session);
    _listViewScrollController.addListener((setScrollController));
  }

  @override
  Future<void> close() {
    _listViewScrollController.dispose();
    return super.close();
  }

  Future<void> getCachedSchedules(KronoxUserModel? session) async {
    final currentScheduleIds = _preferenceService.bookmarkIds;
    List<List<Day>> matrixListOfDays = [];
    List<ScheduleModel> listOfScheduleModels = [];
    if (currentScheduleIds != null) {
      for (String? scheduleId in currentScheduleIds) {
        final bool userHasBookmarks = _preferenceService.userHasBookmarks;

        final bool? toggledToBeVisible = _preferenceService.bookmarkVisible(scheduleId);

        if (scheduleId != null && userHasBookmarks) {
          if (toggledToBeVisible != null && toggledToBeVisible) {
            log('Updating schedule');
            final ScheduleOrProgrammeResponse apiResponse = await _cacheAndInteractionService.findSchedule(scheduleId);

            switch (apiResponse.status) {
              case ScheduleOrProgrammeStatus.CACHED:
              case ScheduleOrProgrammeStatus.FETCHED:
                ScheduleModel newScheduleModel = apiResponse.data;
                if (newScheduleModel.isNotPhonySchedule()) {
                  await DayListBuilder.updateCourseColorStorage(
                      newScheduleModel, await _databaseService.getCourseColors(), _databaseService.updateCourseColor);
                  matrixListOfDays.add(newScheduleModel.days);
                  listOfScheduleModels.add(ScheduleModel(
                      cachedAt: newScheduleModel.cachedAt, id: newScheduleModel.id, days: newScheduleModel.days));
                }
                break;

              case ScheduleOrProgrammeStatus.ERROR:

                /// If an error occurs here, the schedule is empty currently
                /// and can be temporarily removed from the database for this session.
                //await _databaseService.remove(scheduleId, AccessStores.SCHEDULE_STORE);
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
    }
    await _setScheduleView(matrixListOfDays, listOfScheduleModels);
  }

  Future _setScheduleView(List<List<Day>> matrixListOfDays, List<ScheduleModel> listOfScheduleModels) async {
    if (listOfScheduleModels.isNotEmpty) {
      Map<String, int> courseColors = await _databaseService.getCourseColors();

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
        listOfDays: listOfDays,
        listOfWeeks: listOfDays.splitToWeek(),
        listOfScheduleModels: listOfScheduleModels,
        courseColors: courseColors,
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

  Future<bool> createNotificationForEvent(Event inputEvent, BuildContext context) {
    return _notificationService.allowedNotifications().then((isAllowed) async {
      if (isAllowed) {
        final List<ScheduleModel> allSchedules = await _databaseService.getAll();
        final String channelKey = allSchedules
            .firstWhere((scheduleModel) => scheduleModel.days
                .expand((days) => days.events)
                .map((event) => event.course.id)
                .contains(inputEvent.course.id))
            .id;

        _notificationBuilder.buildOffsetNotification(
            id: inputEvent.id.encodeUniqueIdentifier(),
            channelKey: channelKey,
            groupkey: inputEvent.course.id,
            title: inputEvent.title.capitalize(),
            body: inputEvent.course.englishName,
            date: inputEvent.from);

        log(name: 'schedule_view_cubit', 'Created notification for event "${inputEvent.title.capitalize()}"');
        return true;
      }
      log(name: 'schedule_view_cubit', 'No new notifications created. User not allowed');
      return false;
    });
  }

  Future<List<dynamic>> createNotificationForCourse(Event inputEvent, BuildContext context) async {
    return _notificationService.allowedNotifications().then((isAllowed) async {
      if (isAllowed) {
        final List<ScheduleModel> allSchedules = await _databaseService.getAll();

        List<Event> events = allSchedules
            .map((scheduleModel) => scheduleModel.days)
            .expand((listOfDays) =>
                listOfDays.expand((day) => day.events.where((event) => event.course.id == inputEvent.course.id)))
            .toList();
        final String channelKey = allSchedules
            .firstWhere((scheduleModel) =>
                scheduleModel.days.expand((days) => days.events).map((event) => event.id).contains(inputEvent.id))
            .id;
        int successfullyCreatedNotifications = 0;
        for (Event event in events) {
          if (event.from.isAfter(DateTime.now())) {
            _notificationBuilder.buildOffsetNotification(
                id: event.id.encodeUniqueIdentifier(),
                channelKey: channelKey,
                groupkey: event.course.id,
                title: event.title,
                body: event.course.englishName,
                date: event.from);
            successfullyCreatedNotifications++;
          }
        }
        log(
            name: 'schedule_view_cubit',
            'Created $successfullyCreatedNotifications new notifications for ${inputEvent.course}');

        return [true, successfullyCreatedNotifications];
      }
      log(name: 'schedule_view_cubit', 'No new notifications created. Not allowed');
      return [false, 0];
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

  void changeCourseColor(BuildContext context, Course course, Color color) async {
    await _databaseService.updateCourseColor(course.id, color.value);
    Map<String, int> courseColors = await _databaseService.getCourseColors();
    emit(state.copyWith(status: ScheduleViewStatus.POPULATED_VIEW, courseColors: courseColors));
  }

  Future<void> permissionRequest(bool value) async {
    if (value) {
      await _notificationService.getPermission();
    }
    await _preferenceService.setNotificationAllowed(value);
  }

  Future<void> forceRefreshAll(KronoxUserModel? session) async {
    final visibleBookmarks = _preferenceService.visibleBookmarkIds;

    for (var bookmark in visibleBookmarks) {
      final ScheduleOrProgrammeResponse apiResponse =
          await _cacheAndInteractionService.updateSchedule(bookmark.scheduleId);

      switch (apiResponse.status) {
        case ScheduleOrProgrammeStatus.FETCHED:
          final newScheduleModel = apiResponse.data as ScheduleModel;

          await DayListBuilder.updateCourseColorStorage(
              newScheduleModel, await _databaseService.getCourseColors(), _databaseService.updateCourseColor);

          /// Update database with new information, except for the
          /// course colors in [.days]. So when we do getCachedSchedules()
          /// afterwards, it will have the same colors as before refreshing
          await _databaseService.update(
              ScheduleModel(cachedAt: newScheduleModel.cachedAt, id: newScheduleModel.id, days: newScheduleModel.days));
          break;
        default:
          break;
      }
    }
    await getCachedSchedules(session);
  }

  void cancelAllNotifications() => _notificationService.cancelAllNotifications();
}
