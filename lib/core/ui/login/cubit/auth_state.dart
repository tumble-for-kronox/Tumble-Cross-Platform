part of 'auth_cubit.dart';

enum AuthStatus { AUTHENTICATED, UNAUTHENTICATED, INITIAL, LOADING }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final UserEventListStatus userEventListStatus;
  final KronoxUserModel? userSession;
  final String? errorMessage;
  final School? school;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool passwordHidden;
  final bool refreshSession;
  final UserEventCollectionModel? userEvents;

  const AuthState({
    required this.authStatus,
    required this.userEventListStatus,
    required this.usernameController,
    required this.passwordController,
    required this.passwordHidden,
    this.userSession,
    this.errorMessage,
    this.school,
    this.userEvents,
    this.refreshSession = false,
  });

  AuthState copyWith(
      {AuthStatus? authStatus,
      UserEventCollectionModel? userEvents,
      bool? refreshSession,
      UserEventListStatus? userEventListStatus,
      String? errorMessage,
      School? school,
      TextEditingController? usernameController,
      TextEditingController? passwordController,
      KronoxUserModel? userSession,
      bool? passwordHidden}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      userEventListStatus: userEventListStatus ?? this.userEventListStatus,
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      errorMessage: errorMessage ?? this.errorMessage,
      school: school ?? this.school,
      userSession: userSession ?? this.userSession,
      passwordHidden: passwordHidden ?? this.passwordHidden,
      userEvents: userEvents ?? this.userEvents,
      refreshSession: refreshSession ?? this.refreshSession,
    );
  }

  @override
  List<Object?> get props => [
        userEventListStatus,
        userEvents,
        refreshSession,
        authStatus,
        usernameController,
        passwordController,
        passwordHidden,
        userSession
      ];
}
