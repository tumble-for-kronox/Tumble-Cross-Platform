// ignore_for_file: constant_identifier_names

part of 'auth_cubit.dart';

enum AuthStatus { AUTHENTICATED, UNAUTHENTICATED, INITIAL, LOADING, ERROR }

class AuthState extends Equatable {
  final AuthStatus status;
  final KronoxUserModel? userSession;
  final School? school;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool passwordHidden;
  final bool autoSignup;
  final bool loginSuccess;
  final String? errorMessage;

  const AuthState(
      {required this.autoSignup,
      required this.status,
      required this.usernameController,
      required this.passwordController,
      required this.passwordHidden,
      required this.loginSuccess,
      this.userSession,
      this.school,
      this.errorMessage});

  AuthState copyWith(
          {AuthStatus? status,
          String? errorMessage,
          School? school,
          TextEditingController? usernameController,
          TextEditingController? passwordController,
          KronoxUserModel? userSession,
          bool? passwordHidden,
          bool? autoSignup,
          bool? loginSuccess}) =>
      AuthState(
          autoSignup: autoSignup ?? this.autoSignup,
          status: status ?? this.status,
          usernameController: usernameController ?? this.usernameController,
          passwordController: passwordController ?? this.passwordController,
          school: school ?? this.school,
          userSession: userSession ?? this.userSession,
          passwordHidden: passwordHidden ?? this.passwordHidden,
          loginSuccess: loginSuccess ?? this.loginSuccess,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [
        status,
        usernameController,
        passwordController,
        passwordHidden,
        userSession,
        autoSignup,
        loginSuccess,
      ];
}
