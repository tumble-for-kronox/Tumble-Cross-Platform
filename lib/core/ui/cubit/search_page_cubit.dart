import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart'
    as api;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/database/data/access_stores.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/backend_models/program_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/schedule_model_and_courses.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit()
      : super(SearchPageState(
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
            previewCurrentScheduleId: null,
            errorDescription: null,
            hasBookmarkedSchedules:
                getIt<PreferenceRepository>().bookmarkIds!.isNotEmpty)) {
    _init();
  }

  final _textEditingControllerSearch = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _cacheService = getIt<CacheRepository>();
  final ScrollController _listViewScrollController = ScrollController();
  final _notificationService = getIt<NotificationRepository>();
  final _databaseService = getIt<DatabaseRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  ScrollController get controller => _listViewScrollController;
  TextEditingController get textEditingControllerSearch =>
      _textEditingControllerSearch;
  FocusNode get focusNode => _focusNode;
  bool get scheduleInBookmarks => _preferenceService
      .bookmarksContainSchedule(state.previewCurrentScheduleId!);
  String get defaultSchool => _preferenceService.defaultSchool!;
  bool get hasBookMarkedSchedules =>
      getIt<PreferenceRepository>().bookmarkIds!.isNotEmpty;

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
    switch (apiResponse.status) {
      case api.ScheduleOrProgrammeStatus.FETCHED:
        bool scheduleFavorited = false;
        ScheduleModel currentScheduleModel = apiResponse.data!;
        if (currentScheduleModel.isNotPhonySchedule()) {
          List<CourseUiModel?> courseUiModels =
              await currentScheduleModel.findNewCourses(id);
          if (_preferenceService.bookmarksContainSchedule(id)) {
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
      case api.ScheduleOrProgrammeStatus.CACHED:
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
      case api.ScheduleOrProgrammeStatus.ERROR:
        emit(
            state.copyWith(previewFetchStatus: PreviewFetchStatus.FETCH_ERROR));
        break;
      default:
        emit(state);
        break;
    }
  }

  Future<void> searchSchedule() async {
    String query = textEditingControllerSearch.text;
    ScheduleOrProgrammeResponse apiResponse =
        await _cacheService.searchProgram(query);

    if (state.focused) {
      switch (apiResponse.status) {
        case ScheduleOrProgrammeStatus.FETCHED:
          ProgramModel program = apiResponse.data as ProgramModel;
          emit(state.copyWith(
              searchPageStatus: SearchPageStatus.FOUND,
              programList: program.items));
          break;
        case ScheduleOrProgrammeStatus.ERROR:
          emit(state.copyWith(
              searchPageStatus: SearchPageStatus.ERROR,
              errorMessage: apiResponse.message,
              errorDescription: apiResponse.description));
          break;
        default:
          break;
      }
    }
    return;
  }

  void setPreviewLoading() {
    emit(state.copyWith(previewFetchStatus: PreviewFetchStatus.LOADING));
  }

  void setSearchLoading() {
    emit(state.copyWith(searchPageStatus: SearchPageStatus.LOADING));
  }

  void resetCubit() {
    if (textEditingControllerSearch.text.isNotEmpty) {
      _textEditingControllerSearch.clear();
    } else {
      _focusNode.unfocus();
      emit(state.copyWith(
          searchPageStatus: SearchPageStatus.INITIAL,
          previewFetchStatus: PreviewFetchStatus.INITIAL,
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

  bookmarkSchedule() async {
    /// Add this schedule to local database
    _databaseService.add(state.previewScheduleModelAndCourses!.scheduleModel);

    List<BookmarkedScheduleModel> bookmarkScheduleModels =
        _preferenceService.bookmarkScheduleModels;
    bookmarkScheduleModels.add(BookmarkedScheduleModel(
        scheduleId: state.previewCurrentScheduleId!, toggledValue: true));
    await _preferenceService.setBookmarks(bookmarkScheduleModels
        .map((bookmark) => jsonEncode(bookmark))
        .toList());

    for (CourseUiModel? courseUiModel
        in state.previewScheduleModelAndCourses!.courses) {
      if (courseUiModel != null) {
        await _databaseService.addCourseInstance(courseUiModel);
      }
    }

    /// Rebuild notification channels
    _notificationService.initialize();

    emit(state.copyWith(
        previewToggledFavorite: true,
        hasBookmarkedSchedules:
            getIt<PreferenceRepository>().bookmarkIds!.isNotEmpty));
    log(name: 'search_page_cubit', 'Finished executing bookmark SAVE');
  }

  unBookmarkSchedule() async {
    final List<BookmarkedScheduleModel> bookmarkScheduleModels =
        _preferenceService.bookmarkScheduleModels;

    bookmarkScheduleModels.removeWhere(
        (bookmark) => bookmark.scheduleId == state.previewCurrentScheduleId);
    await _preferenceService.setBookmarks(bookmarkScheduleModels
        .map((bookmark) => jsonEncode(bookmark))
        .toList());
    await _databaseService.remove(
        state.previewCurrentScheduleId!, AccessStores.COURSE_COLOR_STORE);
    await _databaseService.remove(
        state.previewCurrentScheduleId!, AccessStores.SCHEDULE_STORE);

    _notificationService.removeChannel(state.previewCurrentScheduleId!);

    emit(state.copyWith(
        previewToggledFavorite: false,
        hasBookmarkedSchedules:
            getIt<PreferenceRepository>().bookmarkIds!.isNotEmpty));
    log(name: 'search_page_cubit', 'Finished executing bookmark REMOVE');
  }

  List<String> updateBookmarkView() {
    emit(state.copyWith(
        hasBookmarkedSchedules: _preferenceService.bookmarkIds!.isNotEmpty));
    return _preferenceService.bookmarkIds!;
  }

  void resetPreviewButton() =>
      emit(state.copyWith(previewToggledFavorite: false));
}