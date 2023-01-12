import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/api/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(LoginState(
            usernameController: TextEditingController(),
            passwordController: TextEditingController(),
            passwordHidden: true,
            focused: false,
            loginSuccess: false,
            status: LoginStatus.INITIAL)) {
    _init();
  }

  final _backendRepository = getIt<BackendRepository>();
  final _secureStorage = getIt<SecureStorageRepository>();
  final _focusNodePassword = FocusNode();
  final _focusNodeUsername = FocusNode();

  FocusNode get focusNodePassword => _focusNodePassword;
  FocusNode get focusNodeUsername => _focusNodeUsername;

  String get defaultSchool => getIt<PreferenceRepository>().defaultSchool!;

  void submitLogin(BuildContext context, String school) async {
    final username = state.usernameController.text;
    final password = state.passwordController.text;
    if (!formValidated()) {
      emit(state.copyWith(
          status: LoginStatus.INITIAL,
          errorMessage: RuntimeErrorType.invalidInputFields()));
      return;
    }
    emit(state.copyWith(status: LoginStatus.LOADING));
    ApiResponse userRes = await _backendRepository.postUserLogin(username, password, school);

    state.passwordController.clear();
    switch (userRes.status) {
      case ApiResponseStatus.success:
        storeUserCreds((userRes.data! as KronoxUserModel).refreshToken);
        getIt<PreferenceRepository>().setSchool(school);
        emit(state.copyWith(loginSuccess: true));
        state.usernameController.clear();
        emit(state.copyWith(status: LoginStatus.SUCCESS));
        break;
      case ApiResponseStatus.unauthorized:
        log("UNAUTHORIZED: ${userRes.data}");
        emit(state.copyWith(
            status: LoginStatus.FAIL,
            errorMessage: userRes.data ?? S.general.unauthorized()));
        break;
      case ApiResponseStatus.error:
        emit(state.copyWith(
            status: LoginStatus.FAIL,
            errorMessage: userRes.data ?? S.general.unauthorized()));
        break;
      default:
    }
  }

  void _init() {
    _focusNodePassword.addListener(setFocusNodePassword);
    _focusNodeUsername.addListener(setFocusNodeUsername);
  }

  @override
  Future<void> close() async {
    _focusNodePassword.dispose();
    _focusNodeUsername.dispose();
    super.close();
  }

  void setFocusNodePassword() {
    if (_focusNodePassword.hasFocus) {
      emit(state.copyWith(focused: true));
    } else if (!_focusNodePassword.hasFocus) {
      emit(state.copyWith(focused: false));
    }
  }

  void setFocusNodeUsername() {
    if (_focusNodeUsername.hasFocus) {
      emit(state.copyWith(focused: true));
    } else if (!_focusNodeUsername.hasFocus) {
      emit(state.copyWith(focused: false));
    }
  }

  bool formValidated() {
    final password = state.passwordController.text;
    final username = state.usernameController.text;
    return password != "" && username != "";
  }

  void storeUserCreds(String token) {
    _secureStorage.setRefreshToken(token);
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordHidden: !state.passwordHidden));
  }

  void setFocusFalse() {
    emit(state.copyWith(focused: false));
  }
}
