import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
          status: AuthStatus.INITIAL,
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
          passwordHidden: true,
          loginSuccess: false,
        )) {
    login();
  }
  final _userRepo = getIt<UserRepository>();
  final _secureStorage = getIt<SecureStorageRepository>();

  void submitLogin(BuildContext context, String school) async {
    final username = state.usernameController.text;
    final password = state.passwordController.text;
    if (!formValidated()) {
      emit(state.copyWith(status: AuthStatus.INITIAL, errorMessage: RuntimeErrorType.invalidInputFields()));
      return;
    }
    emit(state.copyWith(status: AuthStatus.LOADING));
    ApiUserResponse userRes = await _userRepo.postUserLogin(username, password, school);

    state.usernameController.clear();
    state.passwordController.clear();
    log(userRes.status.toString());
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

  Future<void> runAutoSignup() async {
    await _userRepo.putRegisterAllAvailableUserEvents(state.userSession!.sessionToken);
  }

  Future<void> login() async {
    final secureStorage = getIt<SecureStorageRepository>();
    final userRepository = getIt<UserRepository>();

    final refreshToken = await secureStorage.getRefreshToken();
    if (refreshToken != null) {
      ApiUserResponse loggedInUser = await userRepository.getRefreshSession(refreshToken);
      switch (loggedInUser.status) {
        case ApiUserResponseStatus.AUTHORIZED:
          log("LOGGED USER IN AGAIN!");
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
}
