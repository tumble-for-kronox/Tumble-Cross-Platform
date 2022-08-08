// ignore_for_file: constant_identifier_names

part of 'main_app_cubit.dart';

enum MainAppStatus {
  INITIAL,
  LOADING,
  SCHEDULE_SELECTED,
  FETCH_ERROR,
  EMPTY_SCHEDULE
}

class MainAppState extends Equatable {
  final MainAppStatus status;
  final bool toggledFavorite;
  final bool listViewToTopButtonVisible;
  final String? currentScheduleId;
  final List<Day>? listOfDays;
  final List<Week>? listOfWeeks;
  final String? message;
  final ScheduleModelAndCourses? scheduleModelAndCourses;
  const MainAppState(
      {required this.status,
      required this.scheduleModelAndCourses,
      required this.currentScheduleId,
      required this.listOfDays,
      required this.listOfWeeks,
      required this.toggledFavorite,
      required this.listViewToTopButtonVisible,
      required this.message});

  MainAppState copyWith(
          {MainAppStatus? status,
          bool? toggledFavorite,
          bool? listViewToTopButtonVisible,
          String? currentScheduleId,
          List<Day>? listOfDays,
          List<Week>? listOfWeeks,
          String? message,
          ScheduleModelAndCourses? scheduleModelAndCourses}) =>
      MainAppState(
          status: status ?? this.status,
          toggledFavorite: toggledFavorite ?? this.toggledFavorite,
          listViewToTopButtonVisible:
              listViewToTopButtonVisible ?? this.listViewToTopButtonVisible,
          currentScheduleId: currentScheduleId ?? this.currentScheduleId,
          listOfDays: listOfDays ?? this.listOfDays,
          listOfWeeks: listOfWeeks ?? this.listOfWeeks,
          message: message ?? this.message,
          scheduleModelAndCourses:
              scheduleModelAndCourses ?? this.scheduleModelAndCourses);

  @override
  List<Object?> get props => [
        status,
        currentScheduleId,
        listOfDays,
        listOfWeeks,
        toggledFavorite,
        listViewToTopButtonVisible,
        message,
        scheduleModelAndCourses
      ];
}
