import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:tumble/core/api/apiservices/api_response.dart' as api;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/builders/notification_service_builder.dart';
import 'package:tumble/core/api/repository/cache_and_interaction_repository.dart';
import 'package:tumble/core/database/data/access_stores.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/api_models/program_model.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/schedule_model_and_courses.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/ui/data/scaffold_message_types.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit()
      : super(const SearchPageState(
            focused: false,
            searchPageStatus: SearchPageStatus.INITIAL,
            previewFetchStatus: PreviewFetchStatus.INITIAL,
            clearButtonVisible: false,
            errorMessage: null,
            programList: null,
            previewToTopButtonVisible: false,
            previewScheduleModelAndCourses: null,
            previewListOfDays: null,
            previewToggledFavorite: false,
            previewCurrentScheduleId: null));

  final _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _cacheAndInteractionService = getIt<CacheAndInteractionRepository>();
  final ScrollController _listViewScrollController = ScrollController();
  final _sharedPrefs = getIt<SharedPreferences>();
  final _notificationBuilder = NotificationServiceBuilder();
  final _awesomeNotifications = getIt<AwesomeNotifications>();
  final _databaseService = getIt<DatabaseRepository>();
  final _preferenceService = getIt<SharedPreferences>();

  ScrollController get controller => _listViewScrollController;
  TextEditingController get textEditingController => _textEditingController;
  FocusNode get focusNode => _focusNode;

  Future<void> init() async {
    _focusNode.addListener((setSearchBarFocused));
    _listViewScrollController.addListener((setScrollController));
  }

  setScrollController() {
    if (_listViewScrollController.offset >= 1000) {
      emit(state.copyWith(previewToTopButtonVisible: true));
    } else {
      emit(state.copyWith(previewToTopButtonVisible: false));
    }
  }

  @override
  Future<void> close() async {
    _focusNode.dispose();
    _textEditingController.dispose();
    _listViewScrollController.dispose();
    return super.close();
  }

  Future<void> fetchNewSchedule(String id) async {
    final apiResponse = await _cacheAndInteractionService.getSchedule(id);
    switch (apiResponse.status) {
      case api.ApiStatus.UPDATE:
      case api.ApiStatus.FETCHED:
        bool scheduleFavorited = false;
        ScheduleModel currentScheduleModel = apiResponse.data!;
        if (currentScheduleModel.isNotPhonySchedule()) {
          List<CourseUiModel?> courseUiModels =
              await currentScheduleModel.findNewCourses(id);
          if (_preferenceService
              .getStringList(PreferenceTypes.bookmarks)!
              .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
              .contains(id)) {
            for (CourseUiModel? courseUiModel in courseUiModels) {
              if (courseUiModel != null) {
                _databaseService.addCourseInstance(courseUiModel);
              }
            }
            scheduleFavorited = true;
          }

          emit(state.copyWith(
            previewFetchStatus: PreviewFetchStatus.FETCHED_SCHEDULE,
            previewCurrentScheduleId: currentScheduleModel.id,
            previewListOfDays: currentScheduleModel.days,
            previewToggledFavorite: scheduleFavorited,
            previewScheduleModelAndCourses: ScheduleModelAndCourses(
                scheduleModel: currentScheduleModel,
                courses: scheduleFavorited
                    ? await _databaseService.getCachedCoursesFromId(id)
                    : courseUiModels),
            previewToTopButtonVisible: false,
          ));
        } else {
          emit(state.copyWith(
              previewFetchStatus: PreviewFetchStatus.EMPTY_SCHEDULE));
        }
        break;
      case api.ApiStatus.CACHED:
        ScheduleModel currentScheduleModel = apiResponse.data!;
        if (currentScheduleModel.isNotPhonySchedule()) {
          emit(state.copyWith(
            previewFetchStatus: PreviewFetchStatus.CACHED_SCHEDULE,
            previewCurrentScheduleId: currentScheduleModel.id,
            previewListOfDays: currentScheduleModel.days,
            previewToggledFavorite: true,
            previewScheduleModelAndCourses: ScheduleModelAndCourses(
                scheduleModel: currentScheduleModel,
                courses: await _databaseService.getCachedCoursesFromId(id)),
            previewToTopButtonVisible: false,
          ));
        } else {
          emit(state.copyWith(
            previewFetchStatus: PreviewFetchStatus.EMPTY_SCHEDULE,
          ));
        }
        break;
      case api.ApiStatus.ERROR:
        emit(
            state.copyWith(previewFetchStatus: PreviewFetchStatus.FETCH_ERROR));
        break;
      default:
        emit(state);
        break;
    }
  }

  Future<void> search() async {
    emit(state.copyWith(searchPageStatus: SearchPageStatus.LOADING));
    String query = textEditingController.text;
    ApiResponse apiResponse =
        await _cacheAndInteractionService.getProgramsRequest(query);

    if (state.focused) {
      switch (apiResponse.status) {
        case ApiStatus.FETCHED:
          ProgramModel program = apiResponse.data as ProgramModel;
          emit(state.copyWith(
              searchPageStatus: SearchPageStatus.FOUND,
              programList: program.items));
          break;
        case ApiStatus.ERROR:
          emit(state.copyWith(
              searchPageStatus: SearchPageStatus.ERROR,
              errorMessage: apiResponse.message));
          break;
        default:
          break;
      }
    }
    return;
  }

  void setLoading() {
    emit(state.copyWith(previewFetchStatus: PreviewFetchStatus.LOADING));
  }

  void toggleFavorite(BuildContext context) {
    final List<BookmarkedScheduleModel> bookmarks = _sharedPrefs
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json))
        .toList();

    /// If the schedule IS saved in preferences
    if (bookmarks.any(
        (bookmark) => bookmark.scheduleId == state.previewCurrentScheduleId)) {
      _toggleRemove(bookmarks);
      showScaffoldMessage(context,
          ScaffoldMessageType.removedBookmark(state.previewCurrentScheduleId!));
    }

    /// If the schedule IS NOT saved in preferences
    else {
      _toggleSave();
      showScaffoldMessage(context,
          ScaffoldMessageType.addedBookmark(state.previewCurrentScheduleId!));
    }
  }

  void _toggleRemove(List<BookmarkedScheduleModel> bookmarks) async {
    bookmarks.removeWhere(
        (bookmark) => bookmark.scheduleId == state.previewCurrentScheduleId);

    /// Try to remove channel, in case it was default
    final bool wasRemoved = await _awesomeNotifications
        .removeChannel(state.previewCurrentScheduleId!);

    /// If a notification channel was sucessfully removed that
    /// means the one we removed was a default one, now we
    /// need to set the new default one to an open notification channel
    if (wasRemoved && bookmarks.isNotEmpty) {
      _notificationBuilder.buildNotificationChannel(
          channelGroupKey: _sharedPrefs.getString(PreferenceTypes.school)!,
          channelKey: bookmarks.first.scheduleId,
          channelName: 'Notifications for schedule',
          channelDescription: 'Notifications for schedule');
    }

    await _databaseService.remove(
        state.previewCurrentScheduleId!, AccessStores.SCHEDULE_STORE);
    await _databaseService.remove(
        state.previewCurrentScheduleId!, AccessStores.COURSE_COLOR_STORE);

    emit(state.copyWith(previewToggledFavorite: false));

    _sharedPrefs.setStringList(PreferenceTypes.bookmarks,
        bookmarks.map((bookmark) => jsonEncode(bookmark)).toList());
  }

  void _toggleSave() async {
    List<BookmarkedScheduleModel> bookMarkedSchedules = _sharedPrefs
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json))
        .toList();
    bookMarkedSchedules.add(BookmarkedScheduleModel(
        scheduleId: state.previewCurrentScheduleId!, toggledValue: true));
    for (CourseUiModel? courseUiModel
        in state.previewScheduleModelAndCourses!.courses) {
      if (courseUiModel != null) {
        _databaseService.addCourseInstance(courseUiModel);
      }
    }

    await _databaseService
        .add(state.previewScheduleModelAndCourses!.scheduleModel);

    /// Build new notification channel
    _notificationBuilder.buildNotificationChannel(
        channelGroupKey: _sharedPrefs.getString(PreferenceTypes.school)!,
        channelKey: state.previewCurrentScheduleId!,
        channelName: 'Notifications for schedule',
        channelDescription: 'Notifications for schedule');
    emit(state.copyWith(previewToggledFavorite: true));

    _sharedPrefs.setStringList(PreferenceTypes.bookmarks,
        bookMarkedSchedules.map((bookmark) => jsonEncode(bookmark)).toList());
  }

  void resetCubit() {
    if (textEditingController.text.isNotEmpty) {
      _textEditingController.clear();
    } else {
      _focusNode.unfocus();
      emit(state.copyWith(
          searchPageStatus: SearchPageStatus.INITIAL,
          previewFetchStatus: PreviewFetchStatus.INITIAL,
          clearButtonVisible: false,
          programList: null,
          errorMessage: null,
          focused: false));
    }
  }

  setSearchBarFocused() {
    if (_focusNode.hasFocus) {
      emit(state.copyWith(clearButtonVisible: true, focused: true));
    } else if (!_focusNode.hasFocus &&
        _textEditingController.text.trim().isEmpty) {
      emit(state.copyWith(
          clearButtonVisible: false,
          focused: false,
          previewFetchStatus: PreviewFetchStatus.INITIAL,
          previewCurrentScheduleId: null));
    }
  }

  Color getColorForCourse(Event event) {
    return Color(state.previewScheduleModelAndCourses!.courses
        .firstWhere((CourseUiModel? courseUiModel) =>
            courseUiModel!.courseId == event.course.id)!
        .color);
  }

  void scrollToTop() {
    _listViewScrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void displayPreview() {
    emit(state.copyWith(searchPageStatus: SearchPageStatus.DISPLAY_PREVIEW));
  }

  bool scheduleInBookmarks() {
    return _sharedPrefs
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
        .contains(state.previewCurrentScheduleId);
  }
}
