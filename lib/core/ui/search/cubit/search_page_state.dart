// ignore_for_file: constant_identifier_names

part of 'search_page_cubit.dart';

enum SearchPageStatus {
  INITIAL,
  LOADING,
  FOUND,
  NO_SCHEDULES,
  ERROR,
  DISPLAY_PREVIEW
}

enum PreviewFetchStatus {
  INITIAL,
  LOADING,
  CACHED_SCHEDULE,
  FETCHED_SCHEDULE,
  FETCH_ERROR,
  EMPTY_SCHEDULE
}

class SearchPageState extends Equatable {
  final SearchPageStatus searchPageStatus;
  final PreviewFetchStatus previewFetchStatus;
  final bool focused;
  final bool clearButtonVisible;
  final String? errorMessage;
  final List<Item>? programList;
  final bool? previewToTopButtonVisible;
  final ScheduleModelAndCourses? previewScheduleModelAndCourses;
  final List<Day>? previewListOfDays;
  final bool? previewToggledFavorite;
  final String? previewCurrentScheduleId;

  const SearchPageState(
      {required this.focused,
      required this.searchPageStatus,
      required this.previewFetchStatus,
      required this.clearButtonVisible,
      required this.errorMessage,
      required this.programList,
      required this.previewToTopButtonVisible,
      required this.previewScheduleModelAndCourses,
      required this.previewListOfDays,
      required this.previewToggledFavorite,
      required this.previewCurrentScheduleId});

  SearchPageState copyWith(
          {bool? focused,
          SearchPageStatus? searchPageStatus,
          PreviewFetchStatus? previewFetchStatus,
          bool? clearButtonVisible,
          String? errorMessage,
          List<Item>? programList,
          bool? previewToTopButtonVisible,
          ScheduleModelAndCourses? previewScheduleModelAndCourses,
          List<Day>? previewListOfDays,
          List<Week>? previewListOfWeeks,
          bool? previewToggledFavorite,
          String? previewCurrentScheduleId}) =>
      SearchPageState(
          focused: focused ?? this.focused,
          searchPageStatus: searchPageStatus ?? this.searchPageStatus,
          previewFetchStatus: previewFetchStatus ?? this.previewFetchStatus,
          clearButtonVisible: clearButtonVisible ?? this.clearButtonVisible,
          errorMessage: errorMessage ?? this.errorMessage,
          programList: programList ?? this.programList,
          previewToTopButtonVisible:
              previewToTopButtonVisible ?? this.previewToTopButtonVisible,
          previewScheduleModelAndCourses: previewScheduleModelAndCourses ??
              this.previewScheduleModelAndCourses,
          previewListOfDays: previewListOfDays ?? this.previewListOfDays,
          previewToggledFavorite:
              previewToggledFavorite ?? this.previewToggledFavorite,
          previewCurrentScheduleId:
              previewCurrentScheduleId ?? this.previewCurrentScheduleId);

  @override
  List<Object?> get props => [
        clearButtonVisible,
        errorMessage,
        programList,
        focused,
        searchPageStatus,
        previewFetchStatus,
        previewToTopButtonVisible,
        previewScheduleModelAndCourses,
        previewListOfDays,
        previewToggledFavorite,
        previewCurrentScheduleId
      ];
}
