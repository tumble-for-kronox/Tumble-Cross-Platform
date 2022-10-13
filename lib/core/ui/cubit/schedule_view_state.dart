part of 'schedule_view_cubit.dart';

// ignore: constant_identifier_names
enum ScheduleViewStatus { NO_VIEW, EMPTY_SCHEDULE, FETCH_ERROR, INITIAL, LOADING, POPULATED_VIEW }

class ScheduleViewState extends Equatable {
  final ScheduleViewStatus status;
  final bool listViewToTopButtonVisible;
  final List<Day>? listOfDays;
  final List<Week>? listOfWeeks;
  final String? message;
  final List<ScheduleModelAndCourses?>? scheduleModelAndCourses;
  const ScheduleViewState({
    required this.status,
    required this.scheduleModelAndCourses,
    required this.listOfDays,
    required this.listOfWeeks,
    required this.listViewToTopButtonVisible,
    required this.message,
  });

  ScheduleViewState copyWith(
          {ScheduleViewStatus? status,
          bool? toggledFavorite,
          bool? listViewToTopButtonVisible,
          List<Day>? listOfDays,
          List<Week>? listOfWeeks,
          String? message,
          List<ScheduleModelAndCourses?>? scheduleModelAndCourses,
          List<Day>? displayedListItems,
          bool? isLoadingListItems}) =>
      ScheduleViewState(
        status: status ?? this.status,
        listViewToTopButtonVisible: listViewToTopButtonVisible ?? this.listViewToTopButtonVisible,
        listOfDays: listOfDays ?? this.listOfDays,
        listOfWeeks: listOfWeeks ?? this.listOfWeeks,
        message: message ?? this.message,
        scheduleModelAndCourses: scheduleModelAndCourses ?? this.scheduleModelAndCourses,
      );

  @override
  List<Object?> get props => [
        status,
        listOfDays,
        listOfWeeks,
        listViewToTopButtonVisible,
        message,
        scheduleModelAndCourses,
      ];
}
