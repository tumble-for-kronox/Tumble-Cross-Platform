// ignore_for_file: constant_identifier_names

part of 'user_event_cubit.dart';

enum UserOverviewStatus { loading, loaded, error, initial }

enum RegistrationStatus { loading, initial }

class UserEventState extends Equatable {
  final UserOverviewStatus userEventListStatus;
  final RegistrationStatus registerUnregisterStatus;
  final UserEventCollectionModel? userEvents;
  final int? currentTabIndex;
  final bool autoSignup;
  final String? errorMessage;

  const UserEventState({
    required this.userEventListStatus,
    required this.registerUnregisterStatus,
    required this.autoSignup,
    this.userEvents,
    this.errorMessage,
    this.currentTabIndex = 0,
  });

  UserEventState copyWith({
    UserOverviewStatus? userEventListStatus,
    RegistrationStatus? registerUnregisterStatus,
    KronoxUserModel? userSession,
    bool? autoSignup,
    UserEventCollectionModel? userEvents,
    String? errorMessage,
    int? currentTabIndex,
  }) =>
      UserEventState(
        userEventListStatus: userEventListStatus ?? this.userEventListStatus,
        registerUnregisterStatus:
            registerUnregisterStatus ?? this.registerUnregisterStatus,
        autoSignup: autoSignup ?? this.autoSignup,
        userEvents: userEvents ?? this.userEvents,
        errorMessage: errorMessage ?? this.errorMessage,
        currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      );

  @override
  List<Object?> get props => [
        userEventListStatus,
        registerUnregisterStatus,
        autoSignup,
        userEvents,
        currentTabIndex,
      ];
}
