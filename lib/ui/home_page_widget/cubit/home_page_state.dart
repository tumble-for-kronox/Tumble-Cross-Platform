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
  final int index = 1;
  final List<Week>? weekView;
  const HomePageWeekView({this.scheduleId, this.weekView});
}

class HomePageListView extends HomePageState {
  final String? scheduleId;
  final int index = 0;
  final List<Day>? listView;
  const HomePageListView({this.scheduleId, this.listView});
}

class HomePageLoading extends HomePageState {
  const HomePageLoading();
}

class HomePageError extends HomePageState {
  const HomePageError();
}
