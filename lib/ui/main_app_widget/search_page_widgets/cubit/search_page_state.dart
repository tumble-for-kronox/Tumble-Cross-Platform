part of 'search_page_cubit.dart';

@immutable
abstract class SearchPageState {
  const SearchPageState();
}

class SearchPageInitial extends SearchPageState {
  const SearchPageInitial();
}

class SearchPageLoading extends SearchPageState {
  const SearchPageLoading();
}

class SearchPageFoundSchedules extends SearchPageState {
  final List<Item> programList;
  const SearchPageFoundSchedules({required this.programList});
}

class SearchPageNoSchedules extends SearchPageState {
  final String errorType;
  const SearchPageNoSchedules({required this.errorType});
}

class SearchPageFocused extends SearchPageState {
  const SearchPageFocused();
}
