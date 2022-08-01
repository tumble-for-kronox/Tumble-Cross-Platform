import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';

part 'login_page_cubit.dart';

enum LoginPageStatus { INITIAL, LOADING, SUCCESS, FAILED }

class LoginPageState extends Equatable {
  final LoginPageStatus status;
  final String? errorMessage;
  final School? school;
  final KronoxUserModel? userSession;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool passwordHidden;

  const LoginPageState({
    required this.status,
    required this.usernameController,
    required this.passwordController,
    required this.passwordHidden,
    this.userSession,
    this.errorMessage,
    this.school,
  });

  LoginPageState copyWith(
      {LoginPageStatus? status,
      String? errorMessage,
      School? school,
      TextEditingController? usernameController,
      TextEditingController? passwordController,
      KronoxUserModel? userSession,
      bool? passwordHidden}) {
    return LoginPageState(
        status: status ?? this.status,
        usernameController: usernameController ?? this.usernameController,
        passwordController: passwordController ?? this.passwordController,
        errorMessage: errorMessage ?? this.errorMessage,
        school: school ?? this.school,
        userSession: userSession ?? this.userSession,
        passwordHidden: passwordHidden ?? this.passwordHidden);
  }

  @override
  List<Object?> get props =>
      [status, usernameController, passwordController, passwordHidden];
}
