// ignore_for_file: constant_identifier_names

part of 'main_app_cubit.dart';

enum MainAppStatus { INITIAL, LOADING, POPULATED_VIEW, FETCH_ERROR, NO_VIEW }

class MainAppState extends Equatable {
  final MainAppStatus status;
  final bool listViewToTopButtonVisible;
  final List<String?>? currentScheduleIds;
  final List<Day>? listOfDays;
  final List<Week>? listOfWeeks;
  final String? message;
  final List<ScheduleModelAndCourses?>? scheduleModelAndCourses;
  const MainAppState(
      {required this.status,
      required this.scheduleModelAndCourses,
      required this.currentScheduleIds,
      required this.listOfDays,
      required this.listOfWeeks,
      required this.listViewToTopButtonVisible,
      required this.message});

  MainAppState copyWith(
          {MainAppStatus? status,
          bool? toggledFavorite,
          bool? listViewToTopButtonVisible,
          List<String?>? currentScheduleIds,
          List<Day>? listOfDays,
          List<Week>? listOfWeeks,
          String? message,
          List<ScheduleModelAndCourses?>? scheduleModelAndCourses}) =>
      MainAppState(
          status: status ?? this.status,
          listViewToTopButtonVisible:
              listViewToTopButtonVisible ?? this.listViewToTopButtonVisible,
          currentScheduleIds: currentScheduleIds ?? this.currentScheduleIds,
          listOfDays: listOfDays ?? this.listOfDays,
          listOfWeeks: listOfWeeks ?? this.listOfWeeks,
          message: message ?? this.message,
          scheduleModelAndCourses:
              scheduleModelAndCourses ?? this.scheduleModelAndCourses);

  @override
  List<Object?> get props => [
        status,
        currentScheduleIds,
        listOfDays,
        listOfWeeks,
        listViewToTopButtonVisible,
        message,
        scheduleModelAndCourses
      ];
}
