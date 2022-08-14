// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer' as dev;
import 'dart:math';
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
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/schedule_model_and_courses.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/api/apiservices/api_response.dart' as api;
import 'package:tumble/core/ui/data/scaffold_message_types.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit()
      : super(const MainAppState(
            status: MainAppStatus.INITIAL,
            currentScheduleId: null,
            listOfDays: null,
            listOfWeeks: null,
            toggledFavorite: false,
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
  bool get isBookmarked => state.toggledFavorite;

  Future<void> init() async {
    await tryCached();
    _listViewScrollController.addListener((setScrollController));
  }

  Future<void> toggleFavorite(BuildContext context) async {
    final currentFavorites = _sharedPrefs.getStringList(PreferenceTypes.favorites);

    /// If the schedule IS saved in preferences
    if (currentFavorites!.contains(state.currentScheduleId)) {
      _toggleRemove(currentFavorites);
      showScaffoldMessage(context, ScaffoldMessageType.removedBookmark(state.currentScheduleId!));
    }

    /// If the schedule IS NOT saved in preferences
    else {
      _toggleSave(currentFavorites);
      showScaffoldMessage(context, ScaffoldMessageType.addedBookmark(state.currentScheduleId!));
    }
  }

  void _toggleRemove(List<String> currentFavorites) async {
    currentFavorites.remove(state.currentScheduleId);

    /// Try to remove channel, in case it was default
    final bool wasRemoved = await _awesomeNotifications.removeChannel(state.currentScheduleId!);

    (currentFavorites.isEmpty)
        ? _sharedPrefs.remove(PreferenceTypes.schedule)
        : _sharedPrefs.setString(PreferenceTypes.schedule, currentFavorites.first);

    /// If a notification channel was sucessfully removed that
    /// means the one we removed was a default one, now we
    /// need to set the new default one to an open notification channel
    if (wasRemoved && currentFavorites.isNotEmpty) {
      _notificationBuilder.buildNotificationChannel(
          channelGroupKey: _sharedPrefs.getString(PreferenceTypes.school)!,
          channelKey: currentFavorites.first,
          channelName: 'Notifications for schedule',
          channelDescription: 'Notifications for schedule');
    }

    await _databaseService.remove(state.currentScheduleId!);
    emit(state.copyWith(toggledFavorite: false));
    _sharedPrefs.setStringList(PreferenceTypes.favorites, currentFavorites);
  }

  void _toggleSave(List<String> currentFavorites) async {
    currentFavorites.add(state.currentScheduleId!);
    _sharedPrefs.setString(PreferenceTypes.schedule, state.currentScheduleId!);
    await _databaseService.add(state.scheduleModelAndCourses!.scheduleModel);

    /// Make sure we only ever have one notification channel
    /// open at a time
    if (currentFavorites.length > 1) {
      await _awesomeNotifications.removeChannel(currentFavorites[currentFavorites.length - 2]);
    }

    /// Build new notification channel
    _notificationBuilder.buildNotificationChannel(
        channelGroupKey: _sharedPrefs.getString(PreferenceTypes.school)!,
        channelKey: state.currentScheduleId!,
        channelName: 'Notifications for schedule',
        channelDescription: 'Notifications for schedule');
    emit(state.copyWith(toggledFavorite: true));

    _sharedPrefs.setStringList(PreferenceTypes.favorites, currentFavorites);
  }

  Future<void> tryCached() async {
    /// Prevents app from loading default schedule when state is changed.
    /// For example if the user has a default schedule on boot, but has
    /// loaded a different one from search.
    if (state.currentScheduleId != null) {
      return;
    }
    final ApiResponse _apiResponse = await _cacheAndInteractionService.getCachedBookmarkedSchedule();

    switch (_apiResponse.status) {
      case ApiStatus.CACHED:
        ScheduleModel currentScheduleModel = _apiResponse.data!;
        if (currentScheduleModel.isNotPhonySchedule()) {
          emit(state.copyWith(
              status: MainAppStatus.SCHEDULE_SELECTED,
              currentScheduleId: currentScheduleModel.id,
              listOfDays: currentScheduleModel.days,
              listOfWeeks: currentScheduleModel.splitToWeek(),
              toggledFavorite: true,
              scheduleModelAndCourses: ScheduleModelAndCourses(
                  scheduleModel: currentScheduleModel,
                  courses: await _databaseService.getCachedCoursesFromId(currentScheduleModel.id))));
        } else {
          emit(state.copyWith(status: MainAppStatus.EMPTY_SCHEDULE));
        }
        break;
      default:
        emit(state);
    }
  }

  /// ON program change, refresh or initial select
  Future<void> fetchNewSchedule(String id) async {
    final _apiResponse = await _cacheAndInteractionService.getSchedule(id);
    switch (_apiResponse.status) {
      case api.ApiStatus.UPDATE:
      case api.ApiStatus.FETCHED:
        ScheduleModel currentScheduleModel = _apiResponse.data!;
        if (currentScheduleModel.isNotPhonySchedule()) {
          List<CourseUiModel?> courseUiModels = currentScheduleModel.findNewCourses();
          for (CourseUiModel? courseUiModel in courseUiModels) {
            if (courseUiModel != null) {
              _databaseService.addCourseInstance(courseUiModel);
            }
          }
          emit(MainAppState(
              status: MainAppStatus.SCHEDULE_SELECTED,
              currentScheduleId: currentScheduleModel.id,
              listOfDays: currentScheduleModel.days,
              listOfWeeks: currentScheduleModel.splitToWeek(),
              toggledFavorite: false,
              scheduleModelAndCourses:
                  ScheduleModelAndCourses(scheduleModel: currentScheduleModel, courses: courseUiModels),
              listViewToTopButtonVisible: false,
              message: null));
        } else {
          emit(state.copyWith(status: MainAppStatus.EMPTY_SCHEDULE));
        }
        break;
      case api.ApiStatus.CACHED:
        ScheduleModel currentScheduleModel = _apiResponse.data!;
        if (currentScheduleModel.isNotPhonySchedule()) {
          emit(MainAppState(
              status: MainAppStatus.SCHEDULE_SELECTED,
              currentScheduleId: currentScheduleModel.id,
              listOfDays: currentScheduleModel.days,
              listOfWeeks: currentScheduleModel.splitToWeek(),
              toggledFavorite: true,
              scheduleModelAndCourses: ScheduleModelAndCourses(
                  scheduleModel: currentScheduleModel, courses: await _databaseService.getCachedCoursesFromId(id)),
              listViewToTopButtonVisible: false,
              message: null));
        } else {
          emit(state.copyWith(status: MainAppStatus.EMPTY_SCHEDULE, message: RuntimeErrorType.noBookmarks));
        }
        break;
      case api.ApiStatus.ERROR:
        emit(state.copyWith(message: _apiResponse.message, status: MainAppStatus.FETCH_ERROR));
        break;
      default:
        emit(state);
        break;
    }
  }

  Future<void> swapScheduleDefaultView(String id) async {
    ScheduleModel? newDefaultSchedule = await _databaseService.getOneSchedule(id);
    if (newDefaultSchedule != null) {
      emit(MainAppState(
          status: MainAppStatus.SCHEDULE_SELECTED,
          scheduleModelAndCourses: ScheduleModelAndCourses(
              scheduleModel: newDefaultSchedule, courses: await _databaseService.getCachedCoursesFromId(id)),
          currentScheduleId: id,
          listOfDays: newDefaultSchedule.days,
          listOfWeeks: newDefaultSchedule.splitToWeek(),
          toggledFavorite: true,
          listViewToTopButtonVisible: false,
          message: null));
    }
    emit(state.copyWith(message: RuntimeErrorType.scheduleFetchError));
  }

  setScrollController() {
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
    emit(state.copyWith(status: MainAppStatus.LOADING));
  }

  @override
  Future<void> close() {
    _listViewScrollController.dispose();
    return super.close();
  }

  Color getColorForCourse(Event event) {
    return Color(state.scheduleModelAndCourses!.courses
        .firstWhere((CourseUiModel? courseUiModel) => courseUiModel!.courseId == event.course.id)!
        .color);
  }

  Future<bool> createNotificationForEvent(Event event, BuildContext context) async {
    return _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        _notificationBuilder.buildNotification(
            id: event.id.encodeUniqueIdentifier(),
            channelKey: _sharedPrefs.getString(PreferenceTypes.schedule)!,
            groupkey: event.course.id,
            title: event.title,
            body: event.course.englishName,
            date: event.from.subtract(Duration(minutes: _sharedPrefs.getInt(PreferenceTypes.notificationTime)!)));
        dev.log('Created notification for event "${event.title}"');
        showScaffoldMessage(context, ScaffoldMessageType.createdNotificationForEvent(event.title));
        return true;
      }
      dev.log('No new notifications created. Not allowed');
      return false;
    });
  }

  Future<bool> createNotificationForCourse(Event event, BuildContext context) async {
    return _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        List<Event> events = state.scheduleModelAndCourses!.scheduleModel.days
            .expand((Day day) => day.events) // Flatten nested list
            .toList()
            .where((Event eventInDefaultSchedule) => event.course.id == eventInDefaultSchedule.course.id)
            .toList();
        event.id.encodeUniqueIdentifier();
        for (Event event in events) {
          _notificationBuilder.buildNotification(
              id: event.id.encodeUniqueIdentifier(),
              channelKey: _sharedPrefs.getString(PreferenceTypes.schedule)!,
              groupkey: event.course.id,
              title: event.title,
              body: event.course.englishName,
              date: event.from.subtract(Duration(minutes: _sharedPrefs.getInt(PreferenceTypes.notificationTime)!)));
        }
        dev.log('Created ${events.length} new notifications for ${event.course}');
        showScaffoldMessage(
            context, ScaffoldMessageType.createdNotificationForCourse(event.course.englishName, events.length));
        return true;
      }
      dev.log('No new notifications created. Not allowed');
      return false;
    });
  }

  permissionRequest() async {
    await _awesomeNotifications.requestPermissionToSendNotifications();
  }

  bool isDefault(String id) {
    final String userDefaultSchedule = _sharedPrefs.getString(PreferenceTypes.schedule)!;
    return state.scheduleModelAndCourses!.scheduleModel.id == userDefaultSchedule;
  }
}
