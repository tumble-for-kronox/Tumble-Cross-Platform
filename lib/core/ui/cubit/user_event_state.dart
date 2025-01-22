// ignore_for_file: constant_identifier_names

part of 'user_event_cubit.dart';

enum UserOverviewStatus { LOADING, LOADED, ERROR, INITIAL }

enum RegisterUnregisterStatus { LOADING, INITIAL }

class UserEventState extends Equatable {
  final UserOverviewStatus userEventListStatus;
  final RegisterUnregisterStatus registerUnregisterStatus;
  final UserEventCollectionModel? userEvents;
  final int? currentTabIndex;
  final String? errorMessage;

  const UserEventState({
    required this.userEventListStatus,
    required this.registerUnregisterStatus,
    this.userEvents,
    this.errorMessage,
    this.currentTabIndex = 0,
  });

  UserEventState copyWith({
    UserOverviewStatus? userEventListStatus,
    RegisterUnregisterStatus? registerUnregisterStatus,
    KronoxUserModel? userSession,
    UserEventCollectionModel? userEvents,
    String? errorMessage,
    int? currentTabIndex,
  }) =>
      UserEventState(
        userEventListStatus: userEventListStatus ?? this.userEventListStatus,
        registerUnregisterStatus: registerUnregisterStatus ?? this.registerUnregisterStatus,
        userEvents: userEvents ?? this.userEvents,
        errorMessage: errorMessage ?? this.errorMessage,
        currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      );

  @override
  List<Object?> get props => [
        userEventListStatus,
        registerUnregisterStatus,
        userEvents,
        currentTabIndex,
      ];
}
