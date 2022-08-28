// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer' as dev;
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
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
import 'package:tumble/core/api/apiservices/api_response.dart' as api;
import 'package:tumble/core/ui/data/scaffold_message_types.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

import '../../../api/repository/notification_repository.dart';
part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit()
      : super(MainAppState(
            status: MainAppStatus.INITIAL,
            currentScheduleIds: getIt<SharedPreferences>()
                .getStringList(PreferenceTypes.bookmarks)!
                .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
                .toList(),
            listOfDays: null,
            listOfWeeks: null,
            listViewToTopButtonVisible: false,
            message: null,
            scheduleModelAndCourses: null));

  final _sharedPrefs = getIt<SharedPreferences>();
  final _cacheAndInteractionService = getIt<CacheAndInteractionRepository>();
  final _notificationBuilder = NotificationServiceBuilder();
  final _awesomeNotifications = getIt<AwesomeNotifications>();
  final _databaseService = getIt<DatabaseRepository>();
  final ScrollController _listViewScrollController = ScrollController();

  ScrollController get controller => _listViewScrollController;
  SharedPreferences get sharedPrefs => _sharedPrefs;
  int get viewType => getIt<SharedPreferences>().getInt(PreferenceTypes.view)!;

  Future<void> init() async {
    await tryCached();
    _listViewScrollController.addListener((setScrollController));
  }

  @override
  Future<void> close() {
    _listViewScrollController.dispose();
    return super.close();
  }

  Future<void> tryCached() async {
    List<ScheduleModelAndCourses> listOfScheduleModelAndCourses = [];
    List<List<Day>> matrixListOfDays = [];
    List<List<Week>> matrixListOfWeeks = [];
    if (state.currentScheduleIds != null) {
      for (String? scheduleId in state.currentScheduleIds!) {
        // Check if bookmarked schedule is toggled to be visible
        // before trying to fetch it
        if (scheduleId != null) {
          if (_sharedPrefs
              .getStringList(PreferenceTypes.bookmarks)!
              .map((json) => bookmarkedScheduleModelFromJson(json))
              .firstWhere((bookmark) => bookmark.scheduleId == scheduleId)
              .toggledValue) {
            final ApiResponse _apiResponse = await _cacheAndInteractionService
                .getCachedBookmarkedSchedule(scheduleId);

            switch (_apiResponse.status) {
              case ApiStatus.CACHED:
                ScheduleModel currentScheduleModel = _apiResponse.data!;
                if (currentScheduleModel.isNotPhonySchedule()) {
                  matrixListOfDays.add(currentScheduleModel.days);
                  matrixListOfWeeks.add(currentScheduleModel.splitToWeek());
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
        }
      }
      if (listOfScheduleModelAndCourses.isNotEmpty) {
        final flattened =
            matrixListOfDays.expand((listOfDays) => listOfDays).toList();
        flattened.sort((prevDay, nextDay) =>
            prevDay.isoString.compareTo(nextDay.isoString));
        final listOfDays = groupBy(flattened, (Day day) => day.date)
            .entries
            .map((dayGrouper) => Day(
                name: dayGrouper.value[0].name,
                date: dayGrouper.value[0].date,
                isoString: dayGrouper.value[0].isoString,
                weekNumber: dayGrouper.value[0].weekNumber,
                events:
                    dayGrouper.value.expand((Day day) => day.events).toList()))
            .toList();
        emit(state.copyWith(
          status: MainAppStatus.POPULATED_VIEW,
          scheduleModelAndCourses: listOfScheduleModelAndCourses,
          listOfDays: listOfDays,
          listOfWeeks:
              matrixListOfWeeks.expand((listOfWeeks) => listOfWeeks).toList(),
        ));
      }
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
            title: event.title,
            body: event.course.englishName,
            date: event.from.subtract(Duration(
                minutes:
                    _sharedPrefs.getInt(PreferenceTypes.notificationTime)!)));
        dev.log('Created notification for event "${event.title}"');
        showScaffoldMessage(context,
            ScaffoldMessageType.createdNotificationForEvent(event.title));
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
              date: event.from.subtract(Duration(
                  minutes:
                      _sharedPrefs.getInt(PreferenceTypes.notificationTime)!)));
        }
        dev.log(
            'Created ${events.length} new notifications for ${event.course}');
        showScaffoldMessage(
            context,
            ScaffoldMessageType.createdNotificationForCourse(
                event.course.englishName, events.length));
        return true;
      }
      dev.log('No new notifications created. Not allowed');
      return false;
    });
  }

  Future<bool> isNotificationSetForEvent(Event event) async {
    return (await _awesomeNotifications.listScheduledNotifications()).any(
        (element) => element.content!.id == event.id.encodeUniqueIdentifier());
  }

  Future<bool> isNotificationSetForCourse(Event event) async {
    return (await _awesomeNotifications.listScheduledNotifications())
        .any((element) => element.content!.groupKey == event.course.id);
  }

  Future<bool> cancelEventNotification(Event event) async {
    await _awesomeNotifications.cancel(event.id.encodeUniqueIdentifier());
    return !await isNotificationSetForEvent(event);
  }

  Future<bool> cancelCourseNotifications(Event event) async {
    await _awesomeNotifications.cancelNotificationsByGroupKey(event.course.id);
    return !await isNotificationSetForCourse(event);
  }

  void changeCourseColor(BuildContext context, Course course, Color color) {
    _databaseService.updateCourseInstance(CourseUiModel(
        scheduleId: state.scheduleModelAndCourses!
            .firstWhere((scheduleModelAndCourses) => scheduleModelAndCourses!
                .courses
                .any((courseUiModel) => courseUiModel!.courseId == course.id))!
            .scheduleModel
            .id,
        courseId: course.id,
        color: color.value));
    showScaffoldMessage(
        context, ScaffoldMessageType.updatedCourseColor(course.englishName));
  }

  permissionRequest() async {
    await _awesomeNotifications.requestPermissionToSendNotifications();
  }

  updateView() {}

  forceRefreshAll() {}
}
