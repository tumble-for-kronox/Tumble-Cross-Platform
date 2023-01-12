import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/repository/backend_service.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/database/repository/secure_storage_service.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/multi_registration_result_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
            status: AuthStatus.initial,
            usernameController: TextEditingController(),
            passwordController: TextEditingController(),
            passwordHidden: true,
            loginSuccess: false,
            focused: false)) {
    login();
  }
  final _backendRepository = getIt<BackendService>();
  final _focusNodePassword = FocusNode();
  final _focusNodeUsername = FocusNode();

  FocusNode get focusNodePassword => _focusNodePassword;
  FocusNode get focusNodeUsername => _focusNodeUsername;

  String get defaultSchool => getIt<SharedPreferenceService>().defaultSchool!;

  void setUserLoggedIn() {
    emit(state.copyWith(status: AuthStatus.authenticated));
  }

  Future<String?> runAutoSignup() async {
    ApiResponse autoSignup =
        await _backendRepository.putRegisterAll(defaultSchool);

    if (autoSignup.status != ApiResponseStatus.completed) {
      return autoSignup.data;
    }
    MultiRegistrationResultModel results =
        autoSignup.data as MultiRegistrationResultModel;
    if (results.failedRegistrations.isEmpty &&
        results.successfulRegistrations.isEmpty) {
      return null;
    }

    if (results.failedRegistrations.isNotEmpty &&
        results.successfulRegistrations.isEmpty) {
      return S.scaffoldMessages
          .autoSignupFailed(results.failedRegistrations.length);
    }

    if (results.failedRegistrations.isEmpty &&
        results.successfulRegistrations.isNotEmpty) {
      return S.scaffoldMessages
          .autoSignupCompleted(results.successfulRegistrations.length);
    }

    return S.scaffoldMessages.autoSignupCompleteAndFail(
        results.successfulRegistrations.length,
        results.failedRegistrations.length);
  }

  Future<void> login() async {
    ApiResponse apiResponse = await _backendRepository.getUser();
    if (apiResponse.status == ApiResponseStatus.success) {
      log(name: 'auth_cubit', "Successfully retrieved user ..");
      emit(state.copyWith(
          status: AuthStatus.authenticated, userSession: apiResponse.data!));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void setUserSession(KronoxUserModel user) {
    if (user == state.userSession) return;
    log(name: 'auth_cubit', 'New user session being set...');
    emit(state.copyWith(status: AuthStatus.authenticated, userSession: user));
  }

  void logout() {
    getIt<SecureStorageService>().clear();
    emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        userSession: null,
        loginSuccess: false));
  }

  bool get authenticated => state.status == AuthStatus.authenticated;
}
