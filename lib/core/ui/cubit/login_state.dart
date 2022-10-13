// ignore_for_file: constant_identifier_names

part of 'login_cubit.dart';

enum LoginStatus { INITIAL, SUCCESS, FAIL, LOADING }

@freezed
class LoginState extends Equatable {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool passwordHidden;
  final bool loginSuccess;
  final String? errorMessage;
  final bool focused;
  final LoginStatus status;

  const LoginState(
      {required this.usernameController,
      required this.passwordController,
      required this.passwordHidden,
      required this.focused,
      required this.loginSuccess,
      required this.status,
      this.errorMessage});

  LoginState copyWith(
          {TextEditingController? usernameController,
          TextEditingController? passwordController,
          bool? passwordHidden,
          bool? loginSuccess,
          String? errorMessage,
          bool? focused,
          LoginStatus? status}) =>
      LoginState(
          usernameController: usernameController ?? this.usernameController,
          passwordController: passwordController ?? this.passwordController,
          passwordHidden: passwordHidden ?? this.passwordHidden,
          focused: focused ?? this.focused,
          loginSuccess: loginSuccess ?? this.loginSuccess,
          status: status ?? this.status);

  @override
  List<Object?> get props => [
        usernameController,
        passwordController,
        passwordHidden,
        loginSuccess,
        errorMessage,
        focused,
        status,
      ];
}
