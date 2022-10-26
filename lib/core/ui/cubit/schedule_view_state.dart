// ignore_for_file: constant_identifier_names

part of 'schedule_view_cubit.dart';

enum ScheduleViewStatus {
  NO_VIEW,
  EMPTY_SCHEDULE,
  FETCH_ERROR,
  INITIAL,
  LOADING,
  POPULATED_VIEW
}

class ScheduleViewState extends Equatable {
  final ScheduleViewStatus status;
  final bool listViewToTopButtonVisible;
  final List<Day>? listOfDays;
  final List<Week>? listOfWeeks;
  final String? message;
  final List<ScheduleModel>? listOfScheduleModels;
  const ScheduleViewState(
      {required this.status,
      required this.listOfDays,
      required this.listOfWeeks,
      required this.listViewToTopButtonVisible,
      required this.message,
      required this.listOfScheduleModels});

  ScheduleViewState copyWith(
          {ScheduleViewStatus? status,
          bool? toggledFavorite,
          bool? listViewToTopButtonVisible,
          List<Day>? listOfDays,
          List<Week>? listOfWeeks,
          String? message,
          List<Day>? displayedListItems,
          bool? isLoadingListItems,
          List<ScheduleModel>? listOfScheduleModels}) =>
      ScheduleViewState(
          status: status ?? this.status,
          listViewToTopButtonVisible:
              listViewToTopButtonVisible ?? this.listViewToTopButtonVisible,
          listOfDays: listOfDays ?? this.listOfDays,
          listOfWeeks: listOfWeeks ?? this.listOfWeeks,
          message: message ?? this.message,
          listOfScheduleModels:
              listOfScheduleModels ?? this.listOfScheduleModels);

  @override
  List<Object?> get props => [
        status,
        listOfDays,
        listOfWeeks,
        listViewToTopButtonVisible,
        message,
        listOfScheduleModels
      ];
}
