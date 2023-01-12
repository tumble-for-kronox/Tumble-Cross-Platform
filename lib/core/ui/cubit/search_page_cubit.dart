import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/backend/repository/cache_service.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/api/database/data/access_stores.dart';
import 'package:tumble/core/api/database/repository/database_service.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/backend_models/program_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/theme/color_picker.dart';
import 'package:tumble/core/ui/schedule/utils/day_list_builder.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit()
      : super(SearchPageState(
            focused: false,
            searchPageStatus: SearchPageStatus.initial,
            previewFetchStatus: PreviewFetchStatus.initial,
            clearButtonVisible: false,
            errorMessage: null,
            programList: null,
            previewToTopButtonVisible: false,
            previewListOfDays: null,
            previewToggledFavorite: false,
            previewCurrentScheduleId: null,
            errorDescription: null,
            hasBookmarkedSchedules:
                getIt<SharedPreferenceService>().bookmarkIds!.isNotEmpty,
            scheduleModel: null)) {
    _init();
  }

  final _textEditingControllerSearch = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _cacheService = getIt<CacheService>();
  final ScrollController _listViewScrollController = ScrollController();
  final _notificationService = getIt<NotificationService>();
  final _databaseService = getIt<DatabaseService>();
  final _preferenceService = getIt<SharedPreferenceService>();

  ScrollController get controller => _listViewScrollController;
  TextEditingController get textEditingControllerSearch =>
      _textEditingControllerSearch;
  FocusNode get focusNode => _focusNode;
  bool get scheduleInBookmarks => _preferenceService
      .bookmarksContainSchedule(state.previewCurrentScheduleId!);
  String get defaultSchool => _preferenceService.defaultSchool!;
  bool get hasBookMarkedSchedules =>
      getIt<SharedPreferenceService>().bookmarkIds!.isNotEmpty;

  Future<void> _init() async {
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
    _textEditingControllerSearch.dispose();
    _listViewScrollController.dispose();
    return super.close();
  }

  Future<void> openSchedule(String id) async {
    final apiResponse = await _cacheService.findSchedule(id);
    ScheduleModel currentScheduleModel = apiResponse.data!;

    /// If the schedule is empty
    if (!currentScheduleModel.isNotPhonySchedule()) {
      emit(state.copyWith(previewFetchStatus: PreviewFetchStatus.empty));
      return;
    }

    /// Fetch course colors from API and check if the schedule is favorited
    Map<String, int> courseColors = await _databaseService.getCourseColors();
    bool scheduleFavorited = _preferenceService.bookmarksContainSchedule(id);

    /// If the response gets a fresh schedule, make sure to update
    /// the colors for the course as they can contain new courses etc.
    if (apiResponse.status == ApiResponseStatus.fetched) {
      courseColors = await DayListBuilder.updateCourseColorStorage(
          currentScheduleModel,
          courseColors,
          _databaseService.updateCourseColor);
    }

    emit(state.copyWith(
      previewFetchStatus: apiResponse.status == ApiResponseStatus.fetched
          ? PreviewFetchStatus.fetched
          : PreviewFetchStatus.cached,
      previewCurrentScheduleId: currentScheduleModel.id,
      previewListOfDays: currentScheduleModel.days,
      previewToggledFavorite: scheduleFavorited,
      previewToTopButtonVisible: false,
      scheduleModel: currentScheduleModel,
      courseColors: courseColors,
    ));
  }

  Future<void> searchSchedule() async {
    if (!state.focused) return;
    String query = textEditingControllerSearch.text;
    ApiResponse apiResponse = await _cacheService.searchProgram(query);
    switch (apiResponse.status) {
      case ApiResponseStatus.fetched:
        ProgramModel program = apiResponse.data as ProgramModel;
        emit(state.copyWith(
            searchPageStatus: SearchPageStatus.found,
            programList: program.items));
        break;
      case ApiResponseStatus.error:
        emit(state.copyWith(
            searchPageStatus: SearchPageStatus.error,
            errorMessage: apiResponse.message,
            errorDescription: apiResponse.description));
        break;
      default:
        break;
    }
  }

  void setPreviewLoading() {
    emit(state.copyWith(previewFetchStatus: PreviewFetchStatus.loading));
  }

  void setSearchLoading() {
    emit(state.copyWith(searchPageStatus: SearchPageStatus.loading));
  }

  void resetCubit() {
    if (textEditingControllerSearch.text.isNotEmpty) {
      _textEditingControllerSearch.clear();
    } else {
      _focusNode.unfocus();
      emit(state.copyWith(
          searchPageStatus: SearchPageStatus.initial,
          previewFetchStatus: PreviewFetchStatus.initial,
          clearButtonVisible: false,
          programList: null,
          errorMessage: null,
          focused: false,
          previewToggledFavorite: false));
    }
  }

  setSearchBarFocused() {
    if (_focusNode.hasFocus) {
      emit(state.copyWith(clearButtonVisible: true, focused: true));
    } else if (!_focusNode.hasFocus &&
        _textEditingControllerSearch.text.trim().isEmpty) {
      emit(state.copyWith(
          clearButtonVisible: false,
          focused: false,
          previewFetchStatus: PreviewFetchStatus.initial,
          previewCurrentScheduleId: null));
    }
  }

  void scrollToTop() {
    _listViewScrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void displayPreview() {
    emit(state.copyWith(searchPageStatus: SearchPageStatus.preview));
  }

  void bookmarkSchedule() async {
    /// Add this schedule to local database with colors assigned
    /// to courseColor parameter of each Course in Schedule Model
    _databaseService.add(state.scheduleModel!);

    List<BookmarkedScheduleModel> bookmarkScheduleModels =
        _preferenceService.bookmarkScheduleModels;
    bookmarkScheduleModels.add(BookmarkedScheduleModel(
        scheduleId: state.previewCurrentScheduleId!, toggledValue: true));
    await _preferenceService.setBookmarks(bookmarkScheduleModels
        .map((bookmark) => jsonEncode(bookmark))
        .toList());

    /// Rebuild notification channels
    _notificationService.initialize();

    emit(state.copyWith(
        previewToggledFavorite: true,
        hasBookmarkedSchedules:
            getIt<SharedPreferenceService>().bookmarkIds!.isNotEmpty));
    log(name: 'search_page_cubit', 'Finished executing bookmark SAVE');
  }

  Future<void> unBookmarkSchedule() async {
    final List<BookmarkedScheduleModel> bookmarkScheduleModels =
        _preferenceService.bookmarkScheduleModels;

    // Remove the schedule from the list of bookmarked schedules
    bookmarkScheduleModels.removeWhere(
        (bookmark) => bookmark.scheduleId == state.previewCurrentScheduleId);

    // Get the schedule from the database
    ScheduleModel? schedule =
        await _databaseService.getOneSchedule(state.previewCurrentScheduleId!);

    // Extract the course ids from the schedule
    List<String> courseIds = schedule!.days
        .expand((day) => day.events)
        .map((event) => event.course)
        .map((course) => course.id)
        .toSet()
        .toList();

    // Update the bookmarks in the shared preferences
    await _preferenceService.setBookmarks(bookmarkScheduleModels
        .map((bookmark) => jsonEncode(bookmark))
        .toList());

    // Remove the schedule from the database
    await _databaseService.remove(
        state.previewCurrentScheduleId!, AccessStores.schedule_store);

    // Remove the course colors from the database
    await _databaseService.removeCourseColors(courseIds);

    // Remove the notification channel
    _notificationService.removeChannel(state.previewCurrentScheduleId!);

    // Emit the updated state
    emit(state.copyWith(
        previewToggledFavorite: false,
        hasBookmarkedSchedules:
            getIt<SharedPreferenceService>().bookmarkIds!.isNotEmpty));
    log(
        name: 'search_page_cubit',
        'Finished executing schedule un-bookmarking');
  }

  List<String> updateBookmarkView() {
    emit(state.copyWith(
        hasBookmarkedSchedules: _preferenceService.bookmarkIds!.isNotEmpty));
    return _preferenceService.bookmarkIds!;
  }

  void resetPreviewButton() =>
      emit(state.copyWith(previewToggledFavorite: false));
}
