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
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
          autoSignup: getIt<SharedPreferences>().getBool(PreferenceTypes.autoSignup)!,
          authStatus: AuthStatus.INITIAL,
          userEventListStatus: UserEventListStatus.INITIAL,
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
          passwordHidden: true,
          loginSuccess: false,
        )) {
    login().then((value) {
      if (state.authStatus == AuthStatus.AUTHENTICATED) {
        log("GETING USER EVENTS");
        getUserEvents();
      }
    });
  }
  final _userRepo = getIt<UserRepository>();
  final _secureStorage = getIt<SecureStorageRepository>();

  Future<void> getUserEvents() async {
    emit(state.copyWith(userEventListStatus: UserEventListStatus.LOADING));
    ApiUserResponse userEventResponse =
        await _userRepo.getUserEvents(state.userSession!.sessionToken);

    switch (userEventResponse.status) {
      case ApiUserResponseStatus.AUTHORIZED:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.LOADED,
            userEvents: userEventResponse.data!,
            refreshSession: false));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        emit(state);
        break;
      default:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            refreshSession: false));
    }
  }

  Future<void> registerUserEvent(String id) async {
    emit(state.copyWith(userEventListStatus: UserEventListStatus.LOADING));
    ApiUserResponse registerResponse = await _userRepo.putRegisterUserEvent(
        id, state.userSession!.sessionToken);

    switch (registerResponse.status) {
      case ApiUserResponseStatus.AUTHORIZED:
        getUserEvents();
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            errorMessage: RuntimeErrorType.loginError()));
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> unregisterUserEvent(String id) async {
    emit(state.copyWith(userEventListStatus: UserEventListStatus.LOADING));
    ApiUserResponse unregisterResponse = await _userRepo.putUnregisterUserEvent(
        id, state.userSession!.sessionToken);

    switch (unregisterResponse.status) {
      case ApiUserResponseStatus.AUTHORIZED:
        getUserEvents();
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            errorMessage: RuntimeErrorType.loginError()));
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> autoSignupToggle(bool value) async {
    getIt<SharedPreferences>().setBool(PreferenceTypes.autoSignup, value);
    emit(state.copyWith(autoSignup: value));
  }

  Future<void> runAutoSignup() async {
    await _userRepo
        .putRegisterAllAvailableUserEvents(state.userSession!.sessionToken);
  }

  void submitLogin(BuildContext context, String school) async {
    final username = state.usernameController.text;
    final password = state.passwordController.text;
    if (!formValidated()) {
      emit(state.copyWith(
          authStatus: AuthStatus.INITIAL,
          errorMessage: RuntimeErrorType.invalidInputFields()));
      return;
    }
    emit(state.copyWith(authStatus: AuthStatus.LOADING));
    ApiUserResponse userRes =
        await _userRepo.postUserLogin(username, password, school);

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
        emit(state.copyWith(authStatus: AuthStatus.AUTHENTICATED, userSession: userRes.data!));

        getUserEvents();
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            authStatus: AuthStatus.INITIAL, errorMessage: userRes.message));
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
    emit(state.copyWith(authStatus: AuthStatus.AUTHENTICATED));
  }

  Future<void> login() async {
    emit(state.copyWith(authStatus: AuthStatus.INITIAL));
    final secureStorage = getIt<SecureStorageRepository>();
    final userRepository = getIt<UserRepository>();

    final refreshToken = await secureStorage.getRefreshToken();
    if (refreshToken != null) {
      ApiUserResponse loggedInUser =
          await userRepository.getRefreshSession(refreshToken);
      switch (loggedInUser.status) {
        case ApiUserResponseStatus.AUTHORIZED:
          emit(state.copyWith(
              authStatus: AuthStatus.AUTHENTICATED,
              userSession: loggedInUser.data!));
          if (state.autoSignup) {
            runAutoSignup();
          }
          return;
        default:
          emit(state.copyWith(authStatus: AuthStatus.UNAUTHENTICATED));
          return;
      }
    }
    emit(state.copyWith(authStatus: AuthStatus.UNAUTHENTICATED));
  }

  void setUserSession(KronoxUserModel user) {
    emit(state.copyWith(
        authStatus: AuthStatus.AUTHENTICATED, userSession: user));
  }

  void logout() {
    getIt<SecureStorageRepository>().clear();
    emit(state.copyWith(authStatus: AuthStatus.UNAUTHENTICATED, userSession: null, loginSuccess: false));

  }

  bool get authenticated => state.authStatus == AuthStatus.AUTHENTICATED;
}
