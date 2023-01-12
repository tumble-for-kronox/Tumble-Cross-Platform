import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/repository/user_action_repository.dart';
import 'package:tumble/core/api/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/multi_registration_result_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
            status: AuthStatus.INITIAL,
            usernameController: TextEditingController(),
            passwordController: TextEditingController(),
            passwordHidden: true,
            loginSuccess: false,
            focused: false)) {
    login();
  }
  final _userRepo = getIt<UserActionRepository>();
  final _backendRepository = getIt<BackendRepository>();
  final _focusNodePassword = FocusNode();
  final _focusNodeUsername = FocusNode();

  FocusNode get focusNodePassword => _focusNodePassword;
  FocusNode get focusNodeUsername => _focusNodeUsername;

  String get defaultSchool => getIt<PreferenceRepository>().defaultSchool!;

  void setUserLoggedIn() {
    emit(state.copyWith(status: AuthStatus.AUTHENTICATED));
  }

  Future<String?> runAutoSignup() async {
    ApiResponse autoSignup = await _userRepo.registerAllAvailableUserEvents();

    switch (autoSignup.status) {
      case ApiResponseStatus.completed:
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
      default:
        break;
    }
    return autoSignup.data;
  }

  Future<void> login() async {
    ApiResponse apiResponse = await _backendRepository.getUser();
    switch (apiResponse.status) {
      case ApiResponseStatus.success:
        log(name: 'auth_cubit', "Successfully retrieved user ..");
        emit(state.copyWith(
            status: AuthStatus.AUTHENTICATED, userSession: apiResponse.data!));
        return;
      default:
        emit(state.copyWith(status: AuthStatus.UNAUTHENTICATED));
        return;
    }
  }

  void setUserSession(KronoxUserModel user) {
    if (user == state.userSession) return;
    log(name: 'auth_cubit', 'New user session being set...');
    emit(state.copyWith(status: AuthStatus.AUTHENTICATED, userSession: user));
  }

  void logout() {
    getIt<SecureStorageRepository>().clear();
    emit(state.copyWith(
        status: AuthStatus.UNAUTHENTICATED,
        userSession: null,
        loginSuccess: false));
  }

  bool get authenticated => state.status == AuthStatus.AUTHENTICATED;
}
