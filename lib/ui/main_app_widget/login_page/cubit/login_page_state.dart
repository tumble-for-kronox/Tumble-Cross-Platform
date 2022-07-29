import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/user_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/database/repository/secure_storage_repository.dart';
import 'package:tumble/models/api_models/kronox_user_model.dart';
import 'package:tumble/models/ui_models/school_model.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/scaffold_message.dart';

part 'login_page_cubit.dart';

enum LoginPageStatus { INITIAL, LOADING, SUCCESS, FAILED }

class LoginPageState extends Equatable {
  final LoginPageStatus status;
  final String? errorMessage;
  final School? school;
  final bool rememberUser;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPageState({
    required this.status,
    this.errorMessage,
    this.school,
    this.rememberUser = false,
  });

  LoginPageState copyWith({
    LoginPageStatus? status,
    String? errorMessage,
    School? school,
    bool? rememberUser,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      school: school ?? this.school,
      rememberUser: rememberUser ?? this.rememberUser,
    );
  }

  @override
  List<Object?> get props => [status, usernameController, passwordController];
}
