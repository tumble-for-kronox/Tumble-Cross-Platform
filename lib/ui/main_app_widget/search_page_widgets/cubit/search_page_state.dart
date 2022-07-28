// ignore_for_file: constant_identifier_names

part of 'search_page_cubit.dart';

enum SearchPageStatus { INITIAL, LOADING, FOUND, NO_SCHEDULES, ERROR }

class SearchPageState extends Equatable {
  final SearchPageStatus status;
  final bool focused;
  final bool clearButtonVisible;
  final String? errorMessage;
  final List<Item>? programList;

  const SearchPageState(this.focused, this.status, this.clearButtonVisible,
      this.errorMessage, this.programList);

  SearchPageState copyWith(
          {bool? focused,
          SearchPageStatus? status,
          bool? clearButtonVisible,
          String? errorMessage,
          List<Item>? programList}) =>
      SearchPageState(
          focused ?? this.focused,
          status ?? this.status,
          clearButtonVisible ?? this.clearButtonVisible,
          errorMessage ?? this.errorMessage,
          programList ?? this.programList);

  @override
  List<Object?> get props =>
      [clearButtonVisible, errorMessage, programList, focused, status];
}
