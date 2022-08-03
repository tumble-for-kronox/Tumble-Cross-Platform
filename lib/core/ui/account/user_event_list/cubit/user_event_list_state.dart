part of 'user_event_list_cubit.dart';

enum UserEventListStatus { LOADING, LOADED, ERROR }

class UserEventListState extends Equatable {
  final UserEventListStatus status;
  final bool refreshSession;
  final UserEventCollectionModel? userEvents;

  const UserEventListState({
    required this.status,
    this.userEvents,
    this.refreshSession = false,
  });

  UserEventListState copyWith({
    UserEventListStatus? status,
    UserEventCollectionModel? userEvents,
    bool? refreshSession,
  }) {
    return UserEventListState(
      status: status ?? this.status,
      userEvents: userEvents ?? this.userEvents,
      refreshSession: refreshSession ?? this.refreshSession,
    );
  }

  @override
  List<Object?> get props => [status, userEvents, refreshSession];
}
