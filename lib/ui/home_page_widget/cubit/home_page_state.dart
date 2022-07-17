part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  const HomePageInitial();
}

class HomePageWeekView extends HomePageState {
  final String? scheduleId;
  final List<Week>? listOfWeeks;
  const HomePageWeekView({this.scheduleId, this.listOfWeeks});
}

class HomePageListView extends HomePageState {
  final String? scheduleId;
  final List<Day>? listOfDays;
  const HomePageListView({this.scheduleId, this.listOfDays});
}

class HomePageLoading extends HomePageState {
  const HomePageLoading();
}

class HomePageError extends HomePageState {
  const HomePageError();
}
