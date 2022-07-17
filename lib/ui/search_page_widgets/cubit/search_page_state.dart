part of 'search_page_cubit.dart';

@immutable
abstract class SearchPageState {
  const SearchPageState();
}

class SearchPageInitial extends SearchPageState {
  final bool focused;
  const SearchPageInitial({required this.focused});
}

class SearchPageLoading extends SearchPageState {
  final bool focused = true;
  const SearchPageLoading();
}

class SearchPageFoundSchedules extends SearchPageState {
  final bool focused = true;
  final List<RequestedSchedule> programList;
  const SearchPageFoundSchedules({required this.programList});
}

class SearchPageNoSchedules extends SearchPageState {
  final bool focused = true;
  const SearchPageNoSchedules();
}
