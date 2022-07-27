part of 'search_page_cubit.dart';

@immutable
abstract class SearchPageState extends Equatable {
  const SearchPageState();
}

class SearchPageInitial extends SearchPageState {
  const SearchPageInitial();

  @override
  List<Object?> get props => [];
}

class SearchPageLoading extends SearchPageState {
  const SearchPageLoading();
  @override
  List<Object?> get props => [];
}

class SearchPageFoundSchedules extends SearchPageState {
  final List<Item> programList;
  const SearchPageFoundSchedules({required this.programList});
  @override
  List<Object?> get props => [programList];
}

class SearchPageNoSchedules extends SearchPageState {
  final String errorType;
  const SearchPageNoSchedules({required this.errorType});
  @override
  List<Object?> get props => [errorType];
}

class SearchPageFocused extends SearchPageState {
  final bool clearVisible;
  const SearchPageFocused(this.clearVisible);
  @override
  List<Object?> get props => [clearVisible];
}
