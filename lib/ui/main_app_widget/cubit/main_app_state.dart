part of 'main_app_cubit.dart';

abstract class MainAppState extends Equatable {
  const MainAppState();
}

class MainAppInitial extends MainAppState {
  final String? fetchErrorType;
  const MainAppInitial(this.fetchErrorType);

  @override
  List<Object?> get props => [];
}

class MainAppLoading extends MainAppState {
  const MainAppLoading();

  @override
  List<Object?> get props => [];
}

class MainAppScheduleSelected extends MainAppState {
  final bool toggledFavorite;
  final String currentScheduleId;
  final List<Day> listOfDays;
  final List<Week> listOfWeeks;
  const MainAppScheduleSelected(
      {required this.currentScheduleId,
      required this.listOfDays,
      required this.listOfWeeks,
      required this.toggledFavorite});

  @override
  List<Object?> get props =>
      [currentScheduleId, listOfDays, listOfWeeks, toggledFavorite];
}
