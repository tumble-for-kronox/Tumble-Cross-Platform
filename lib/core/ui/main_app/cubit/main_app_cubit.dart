// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer' as dev;
import 'package:collection/collection.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/builders/notification_service_builder.dart';
import 'package:tumble/core/api/repository/cache_and_interaction_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/schedule_model_and_courses.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit()
      : super(const MainAppState(
            status: MainAppStatus.LOADING,
            listOfDays: null,
            listOfWeeks: null,
            listViewToTopButtonVisible: false,
            message: null,
            scheduleModelAndCourses: null));

  final _cacheAndInteractionService = getIt<CacheAndInteractionRepository>();
  final _notificationBuilder = NotificationServiceBuilder();
  final _awesomeNotifications = getIt<AwesomeNotifications>();
  final _databaseService = getIt<DatabaseRepository>();
  final _preferenceService = getIt<SharedPreferences>();
  final ScrollController _listViewScrollController = ScrollController();

  ScrollController get controller => _listViewScrollController;
  int get viewType => getIt<SharedPreferences>().getInt(PreferenceTypes.view)!;
  bool get hasBookMarkedSchedules => getIt<SharedPreferences>()
      .getStringList(PreferenceTypes.bookmarks)!
      .isNotEmpty;

  bool toTopButtonVisible() {
    if (_listViewScrollController.hasClients) {
      return _listViewScrollController.offset >= 1000;
    } else {
      return false;
    }
  }

  Future<void> init() async {
    await attemptToFetchCachedSchedules();
    _listViewScrollController.addListener((setScrollController));
  }

  @override
  Future<void> close() {
    _listViewScrollController.dispose();
    return super.close();
  }

  Future<void> attemptToFetchCachedSchedules() async {
    dev.log(_preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .toString());
    final currentScheduleIds = _preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
        .toList();
    List<ScheduleModelAndCourses> listOfScheduleModelAndCourses = [];
    List<List<Day>> matrixListOfDays = [];

    for (String? scheduleId in currentScheduleIds) {
      // Check if bookmarked schedule is toggled to be visible
      // before trying to fetch it
      final bool userHasBookmarks = _preferenceService
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
          .toList()
          .isNotEmpty;

      /// Schedule id might have been removed from preferences
      /// during the running of this method
      final bool? currentScheduleIsToggledToBeVisible = _preferenceService
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json))
          .firstWhereOrNull((bookmark) => bookmark.scheduleId == scheduleId)
          ?.toggledValue;

      if (scheduleId != null && userHasBookmarks) {
        if (currentScheduleIsToggledToBeVisible != null &&
            currentScheduleIsToggledToBeVisible) {
          final ApiScheduleOrProgrammeResponse _apiResponse =
              await _cacheAndInteractionService
                  .getCachedOrNewSchedule(scheduleId);

          switch (_apiResponse.status) {
            case ApiScheduleOrProgrammeStatus.FETCHED:
            case ApiScheduleOrProgrammeStatus.CACHED:
              ScheduleModel currentScheduleModel = _apiResponse.data!;
              if (currentScheduleModel.isNotPhonySchedule()) {
                matrixListOfDays.add(currentScheduleModel.days);
                listOfScheduleModelAndCourses.add(ScheduleModelAndCourses(
                    scheduleModel: currentScheduleModel,
                    courses: await _databaseService
                        .getCachedCoursesFromId(currentScheduleModel.id)));
              }
              break;
            default:
              break;
          }
        }
      } else {
        emit(state.copyWith(status: MainAppStatus.NO_VIEW));
      }
    }
    if (listOfScheduleModelAndCourses.isNotEmpty) {
      final flattened =
          matrixListOfDays.expand((listOfDays) => listOfDays).toList();
      flattened.sort(
          (prevDay, nextDay) => prevDay.isoString.compareTo(nextDay.isoString));

      var seen = <String>{};

      final listOfDays = groupBy(flattened, (Day day) => day.date)
          .entries
          .map((dayGrouper) => Day(
              name: dayGrouper.value[0].name,
              date: dayGrouper.value[0].date,
              isoString: dayGrouper.value[0].isoString,
              weekNumber: dayGrouper.value[0].weekNumber,
              events: dayGrouper.value
                  .expand((day) => day.events)
                  .where((event) => seen.add(event.id))
                  .toList()
                ..sort(((a, b) => a.from.compareTo(b.from)))))
          .toList();

      emit(state.copyWith(
        status: MainAppStatus.POPULATED_VIEW,
        scheduleModelAndCourses: listOfScheduleModelAndCourses,
        listOfDays: listOfDays,
        listOfWeeks: listOfDays.splitToWeek(),
      ));
    } else {
      emit(state.copyWith(status: MainAppStatus.NO_VIEW));
    }
  }

  setScrollController() {
    if (_listViewScrollController.offset >= 1000) {
      emit(state.copyWith(listViewToTopButtonVisible: true));
    } else {
      emit(state.copyWith(listViewToTopButtonVisible: false));
    }
  }

  void scrollToTop() {
    _listViewScrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  setLoading() {
    emit(state.copyWith(status: MainAppStatus.LOADING));
  }

  Color getColorForCourse(Event event) {
    return Color(state.scheduleModelAndCourses!
        .expand((scheduleModelAndCourses) => scheduleModelAndCourses!.courses)
        .firstWhere(
            (courseUiModel) => courseUiModel!.courseId == event.course.id)!
        .color);
  }

  Future<bool> createNotificationForEvent(Event event, BuildContext context) {
    return _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        _notificationBuilder.buildNotification(
            id: event.id.encodeUniqueIdentifier(),
            channelKey: state.scheduleModelAndCourses!
                .firstWhere((scheduleModelAndCourses) =>
                    scheduleModelAndCourses!.courses.any((courseUiModel) =>
                        courseUiModel!.courseId == event.course.id))!
                .scheduleModel
                .id,
            groupkey: event.course.id,
            title: event.title.capitalize(),
            body: event.course.englishName,
            date: event.from);

        dev.log('Created notification for event "${event.title.capitalize()}"');

        showScaffoldMessage(
            context,
            S.scaffoldMessages
                .createdNotificationForEvent(event.title.capitalize()));

        return true;
      }
      dev.log('No new notifications created. Not allowed');
      return false;
    });
  }

  Future<bool> createNotificationForCourse(
      Event event, BuildContext context) async {
    return _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        List<Event> events = state.scheduleModelAndCourses!
            .expand((scheduleModelAndCourses) =>
                scheduleModelAndCourses!.scheduleModel.days)
            .expand((Day day) => day.events) // Flatten nested list
            .toList()
            .where((Event eventInDefaultSchedule) =>
                event.course.id == eventInDefaultSchedule.course.id)
            .toList();

        event.id.encodeUniqueIdentifier();

        for (Event event in events) {
          if (event.from.isAfter(DateTime.now())) {
            _notificationBuilder.buildNotification(
                id: event.id.encodeUniqueIdentifier(),
                channelKey: state.scheduleModelAndCourses!
                    .firstWhere((scheduleModelAndCourses) =>
                        scheduleModelAndCourses!.courses.any((courseUiModel) =>
                            courseUiModel!.courseId == event.course.id))!
                    .scheduleModel
                    .id,
                groupkey: event.course.id,
                title: event.title,
                body: event.course.englishName,
                date: event.from);
          }
        }
        dev.log(
            'Created ${events.length} new notifications for ${event.course}');
        showScaffoldMessage(
            context,
            S.scaffoldMessages.createdNotificationForCourse(
                event.course.englishName, events.length));

        return true;
      }
      dev.log('No new notifications created. Not allowed');
      return false;
    });
  }

  Future<bool> checkIfNotificationIsSetForEvent(Event event) async {
    return (((await _awesomeNotifications.listScheduledNotifications())
            .singleWhereOrNull(
          (notificationModel) =>
              notificationModel.content!.id ==
              event.id.encodeUniqueIdentifier(),
        )) !=
        null);
  }

  /// Returns true if course id is found in current list of notifications
  Future<bool> checkifNotificationIsSetForCourse(Event event) async {
    return (((await _awesomeNotifications.listScheduledNotifications())
            .firstWhereOrNull(
          (notificationModel) =>
              notificationModel.content!.groupKey == event.course.id,
        )) !=
        null);
  }

  Future<bool> cancelEventNotification(Event event) async {
    await _awesomeNotifications
        .cancelSchedule(event.id.encodeUniqueIdentifier());
    return !await checkIfNotificationIsSetForEvent(event);
  }

  /// Returns true if notification is still set for course
  Future<bool> cancelCourseNotifications(Event event) async {
    await _awesomeNotifications.cancelSchedulesByGroupKey(event.course.id);
    return await checkifNotificationIsSetForCourse(event);
  }

  void changeCourseColor(BuildContext context, Course course, Color color) {
    _databaseService
        .updateCourseInstance(CourseUiModel(
            scheduleId: state.scheduleModelAndCourses!
                .firstWhere((scheduleModelAndCourses) =>
                    scheduleModelAndCourses!.courses.any((courseUiModel) =>
                        courseUiModel!.courseId == course.id))!
                .scheduleModel
                .id,
            courseId: course.id,
            color: color.value))
        .then((value) {
      showScaffoldMessage(
          context, S.scaffoldMessages.updatedCourseColor(course.englishName));
      attemptToFetchCachedSchedules();
    });
  }

  permissionRequest() async {
    await _awesomeNotifications.requestPermissionToSendNotifications();
  }

  forceRefreshAll() async {
    final bookmarks = _preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .map((e) => bookmarkedScheduleModelFromJson(e))
        .where((bookmark) => bookmark.toggledValue)
        .toList();

    for (var bookmark in bookmarks) {
      final ApiScheduleOrProgrammeResponse _apiResponse =
          await _cacheAndInteractionService
              .scheduleFetchDispatcher(bookmark.scheduleId);

      switch (_apiResponse.status) {
        case ApiScheduleOrProgrammeStatus.FETCHED:
          await _databaseService.update(_apiResponse.data as ScheduleModel);
          break;
        default:
          break;
      }
    }
    await attemptToFetchCachedSchedules();
  }
}
