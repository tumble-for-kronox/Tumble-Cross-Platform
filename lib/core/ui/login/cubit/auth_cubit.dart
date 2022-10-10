import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/repository/user_action_repository.dart';
import 'package:tumble/core/api/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/multi_registration_result_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
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
    _init();
    login();
  }
  final _userRepo = getIt<UserActionRepository>();
  final _secureStorage = getIt<SecureStorageRepository>();
  final _focusNodePassword = FocusNode();
  final _focusNodeUsername = FocusNode();

  FocusNode get focusNodePassword => _focusNodePassword;
  FocusNode get focusNodeUsername => _focusNodeUsername;

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

  void submitLogin(BuildContext context, String school) async {
    final username = state.usernameController.text;
    final password = state.passwordController.text;
    if (!formValidated()) {
      emit(state.copyWith(status: AuthStatus.INITIAL, errorMessage: RuntimeErrorType.invalidInputFields()));
      return;
    }
    emit(state.copyWith(status: AuthStatus.LOADING));
    UserResponse userRes = await _userRepo.userLogin(username, password, school);

    state.usernameController.clear();
    state.passwordController.clear();
    switch (userRes.status) {
      case ApiUserResponseStatus.AUTHORIZED:
        storeUserCreds((userRes.data! as KronoxUserModel).refreshToken);
        getIt<SharedPreferences>().setString(
          PreferenceTypes.school,
          school,
        );
        emit(state.copyWith(loginSuccess: true));
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(status: AuthStatus.AUTHENTICATED, userSession: userRes.data!));

        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(status: AuthStatus.ERROR, errorMessage: userRes.message));
        break;
      default:
    }
  }

  bool formValidated() {
    final password = state.passwordController.text;
    final username = state.usernameController.text;
    return password != "" && username != "";
  }

  void setSchool(School? school) {
    emit(state.copyWith(school: school));
  }

  void storeUserCreds(String token) {
    _secureStorage.setRefreshToken(token);
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordHidden: !state.passwordHidden));
  }

  void setUserLoggedIn() {
    emit(state.copyWith(status: AuthStatus.AUTHENTICATED));
  }

  Future<String?> runAutoSignup() async {
    UserResponse<dynamic> resp = await _userRepo.registerAllAvailableUserEvents(state.userSession!.sessionToken);

    switch (resp.status) {
      case ApiUserResponseStatus.COMPLETED:
        MultiRegistrationResultModel results = resp.data as MultiRegistrationResultModel;
        if (results.failedRegistrations.isEmpty && results.successfulRegistrations.isEmpty) {
          return null;
        }

        if (results.failedRegistrations.isNotEmpty && results.successfulRegistrations.isEmpty) {
          return S.scaffoldMessages.autoSignupFailed(results.failedRegistrations.length);
        }

        if (results.failedRegistrations.isEmpty && results.successfulRegistrations.isNotEmpty) {
          return S.scaffoldMessages.autoSignupCompleted(results.successfulRegistrations.length);
        }

        return S.scaffoldMessages
            .autoSignupCompleteAndFail(results.successfulRegistrations.length, results.failedRegistrations.length);
      default:
        break;
    }
    return resp.data;
  }

  Future<void> login() async {
    final secureStorage = getIt<SecureStorageRepository>();
    final userRepository = getIt<UserActionRepository>();

    final refreshToken = await secureStorage.getRefreshToken();
    if (refreshToken != null) {
      UserResponse loggedInUser = await userRepository.refreshSession(refreshToken);
      switch (loggedInUser.status) {
        case ApiUserResponseStatus.AUTHORIZED:
          log(name: 'auth_cubit', "Successfully refreshed user session with token ..");
          emit(state.copyWith(status: AuthStatus.AUTHENTICATED, userSession: loggedInUser.data!));

          return;
        default:
          emit(state.copyWith(status: AuthStatus.UNAUTHENTICATED));
          return;
      }
    }
    emit(state.copyWith(status: AuthStatus.UNAUTHENTICATED));
  }

  void setUserSession(KronoxUserModel user) {
    emit(state.copyWith(status: AuthStatus.AUTHENTICATED, userSession: user));
  }

  void logout() {
    getIt<SecureStorageRepository>().clear();
    emit(state.copyWith(status: AuthStatus.UNAUTHENTICATED, userSession: null, loginSuccess: false));
  }

  bool get authenticated => state.status == AuthStatus.AUTHENTICATED;

  void setFocusFalse() {
    emit(state.copyWith(focused: false));
  }
}
