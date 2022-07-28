import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_page_cubit.dart';

enum LoginPageStatus { INITIAL, LOADING, SUCCESS, FAILED }

class LoginPageState extends Equatable {
  final LoginPageStatus status;

  const LoginPageState({
    required this.status,
  });

  LoginPageState copyWith(LoginPageStatus? status) {
    return LoginPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
