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
  final String? errorDescription;
  final List<Item>? programList;
  final bool? previewToTopButtonVisible;
  final List<Day>? previewListOfDays;
  final bool? previewToggledFavorite;
  final String? previewCurrentScheduleId;
  final bool hasBookmarkedSchedules;
  final ScheduleModel? scheduleModel;

  const SearchPageState(
      {required this.focused,
      required this.searchPageStatus,
      required this.previewFetchStatus,
      required this.clearButtonVisible,
      required this.errorMessage,
      required this.programList,
      required this.previewToTopButtonVisible,
      required this.previewListOfDays,
      required this.previewToggledFavorite,
      required this.previewCurrentScheduleId,
      required this.errorDescription,
      required this.hasBookmarkedSchedules,
      required this.scheduleModel});

  SearchPageState copyWith(
          {bool? focused,
          SearchPageStatus? searchPageStatus,
          PreviewFetchStatus? previewFetchStatus,
          bool? clearButtonVisible,
          String? errorMessage,
          List<Item>? programList,
          bool? previewToTopButtonVisible,
          List<Day>? previewListOfDays,
          List<Week>? previewListOfWeeks,
          bool? previewToggledFavorite,
          String? previewCurrentScheduleId,
          String? errorDescription,
          bool? hasBookmarkedSchedules,
          ScheduleModel? scheduleModel}) =>
      SearchPageState(
          focused: focused ?? this.focused,
          searchPageStatus: searchPageStatus ?? this.searchPageStatus,
          previewFetchStatus: previewFetchStatus ?? this.previewFetchStatus,
          clearButtonVisible: clearButtonVisible ?? this.clearButtonVisible,
          errorMessage: errorMessage ?? this.errorMessage,
          programList: programList ?? this.programList,
          previewToTopButtonVisible:
              previewToTopButtonVisible ?? this.previewToTopButtonVisible,
          previewListOfDays: previewListOfDays ?? this.previewListOfDays,
          previewToggledFavorite:
              previewToggledFavorite ?? this.previewToggledFavorite,
          previewCurrentScheduleId:
              previewCurrentScheduleId ?? this.previewCurrentScheduleId,
          errorDescription: errorDescription ?? this.errorDescription,
          hasBookmarkedSchedules:
              hasBookmarkedSchedules ?? this.hasBookmarkedSchedules,
          scheduleModel: scheduleModel ?? this.scheduleModel);

  @override
  List<Object?> get props => [
        clearButtonVisible,
        errorMessage,
        programList,
        focused,
        searchPageStatus,
        previewFetchStatus,
        previewToTopButtonVisible,
        previewListOfDays,
        previewToggledFavorite,
        previewCurrentScheduleId,
        errorDescription,
        hasBookmarkedSchedules,
        scheduleModel
      ];
}
