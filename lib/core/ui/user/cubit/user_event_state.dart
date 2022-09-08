// ignore_for_file: constant_identifier_names

part of 'user_event_cubit.dart';

enum UserOverviewStatus { LOADING, LOADED, ERROR, INITIAL }

class UserEventState extends Equatable {
  final UserOverviewStatus userEventListStatus;
  final UserEventCollectionModel? userEvents;
  final bool autoSignup;
  final String? errorMessage;

  const UserEventState(
      {required this.userEventListStatus,
      required this.autoSignup,
      this.userEvents,
      this.errorMessage});

  UserEventState copyWith(
          {UserOverviewStatus? userEventListStatus,
          KronoxUserModel? userSession,
          bool? autoSignup,
          UserEventCollectionModel? userEvents,
          String? errorMessage}) =>
      UserEventState(
        userEventListStatus: userEventListStatus ?? this.userEventListStatus,
        autoSignup: autoSignup ?? this.autoSignup,
        userEvents: userEvents ?? this.userEvents,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        userEventListStatus,
        autoSignup,
        userEvents,
      ];
}
