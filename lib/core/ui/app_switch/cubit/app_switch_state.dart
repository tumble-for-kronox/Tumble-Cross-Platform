// ignore_for_file: constant_identifier_names

part of 'app_switch_cubit.dart';

enum MainAppStatus {
  INITIAL,
  LOADING,
  POPULATED_VIEW,
  FETCH_ERROR,
  NO_VIEW,
  EMPTY_SCHEDULE
}

class AppSwitchState extends Equatable {
  final MainAppStatus status;
  final bool listViewToTopButtonVisible;
  final List<Day>? listOfDays;
  final List<Week>? listOfWeeks;
  final String? message;
  final List<ScheduleModelAndCourses?>? scheduleModelAndCourses;
  const AppSwitchState(
      {required this.status,
      required this.scheduleModelAndCourses,
      required this.listOfDays,
      required this.listOfWeeks,
      required this.listViewToTopButtonVisible,
      required this.message});

  AppSwitchState copyWith(
          {MainAppStatus? status,
          bool? toggledFavorite,
          bool? listViewToTopButtonVisible,
          List<Day>? listOfDays,
          List<Week>? listOfWeeks,
          String? message,
          List<ScheduleModelAndCourses?>? scheduleModelAndCourses}) =>
      AppSwitchState(
          status: status ?? this.status,
          listViewToTopButtonVisible:
              listViewToTopButtonVisible ?? this.listViewToTopButtonVisible,
          listOfDays: listOfDays ?? this.listOfDays,
          listOfWeeks: listOfWeeks ?? this.listOfWeeks,
          message: message ?? this.message,
          scheduleModelAndCourses:
              scheduleModelAndCourses ?? this.scheduleModelAndCourses);

  @override
  List<Object?> get props => [
        status,
        listOfDays,
        listOfWeeks,
        listViewToTopButtonVisible,
        message,
        scheduleModelAndCourses
      ];
}
