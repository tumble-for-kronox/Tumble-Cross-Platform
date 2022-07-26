part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  const HomePageInitial();

  @override
  List<Object?> get props => [];
}

class HomePageWeekView extends HomePageState {
  final String scheduleId;
  final bool isFavorite;
  final List<Week> listOfWeeks;
  const HomePageWeekView(
      {required this.scheduleId,
      required this.listOfWeeks,
      required this.isFavorite});

  @override
  List<Object?> get props => [scheduleId, listOfWeeks, isFavorite];
}

class HomePageListView extends HomePageState {
  final String scheduleId;
  final bool isFavorite;
  final List<Day> listOfDays;
  const HomePageListView(
      {required this.scheduleId,
      required this.listOfDays,
      required this.isFavorite});

  @override
  List<Object?> get props => [scheduleId, listOfDays, isFavorite];
}

class HomePageLoading extends HomePageState {
  const HomePageLoading();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class HomePageError extends HomePageState {
  final String errorType;
  const HomePageError({required this.errorType});

  @override
  List<Object?> get props => [errorType];
}
