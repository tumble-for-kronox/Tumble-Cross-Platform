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
  final bool loginSuccess;
  final String? errorMessage;
  final bool focused;

  const AuthState(
      {required this.status,
      required this.usernameController,
      required this.passwordController,
      required this.passwordHidden,
      required this.loginSuccess,
      required this.focused,
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
          bool? loginSuccess,
          bool? focused}) =>
      AuthState(
          status: status ?? this.status,
          usernameController: usernameController ?? this.usernameController,
          passwordController: passwordController ?? this.passwordController,
          school: school ?? this.school,
          userSession: userSession ?? this.userSession,
          passwordHidden: passwordHidden ?? this.passwordHidden,
          loginSuccess: loginSuccess ?? this.loginSuccess,
          errorMessage: errorMessage ?? this.errorMessage,
          focused: focused ?? this.focused);

  @override
  List<Object?> get props => [
        status,
        usernameController,
        passwordController,
        passwordHidden,
        userSession,
        loginSuccess,
        focused,
      ];
}
