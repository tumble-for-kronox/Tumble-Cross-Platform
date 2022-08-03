import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/ui/account/user_event_list/cubit/user_event_list_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
            authStatus: AuthStatus.INITIAL,
            userEventListStatus: UserEventListStatus.LOADING,
            usernameController: TextEditingController(),
            passwordController: TextEditingController(),
            passwordHidden: true)) {
    login();
  }
  final _userRepo = locator<UserRepository>();
  final _secureStorage = locator<SecureStorageRepository>();

  Future<void> getUserEvents(String sessionToken) async {
    emit(state.copyWith(userEventListStatus: UserEventListStatus.LOADING));
    ApiResponse userEventResponse = await _userRepo.getUserEvents(sessionToken);

    switch (userEventResponse.status) {
      case ApiStatus.REQUESTED:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.LOADED,
            userEvents: userEventResponse.data!,
            refreshSession: false));
        break;
      case ApiStatus.UNAUTHORIZED:
        emit(state);
        break;
      default:
        emit(state.copyWith(
            userEventListStatus: UserEventListStatus.ERROR,
            refreshSession: false));
    }
  }

  void submitLogin(BuildContext context, String school) async {
    final username = state.usernameController.text;
    final password = state.passwordController.text;
    if (!formValidated()) {
      emit(state.copyWith(
          authStatus: AuthStatus.INITIAL,
          errorMessage: "Username and password cannot be empty."));
      return;
    }
    emit(state.copyWith(authStatus: AuthStatus.LOADING));
    ApiResponse userRes =
        await _userRepo.postUserLogin(username, password, school);

    state.usernameController.clear();
    state.passwordController.clear();
    switch (userRes.status) {
      case ApiStatus.REQUESTED:
        storeUserCreds((userRes.data! as KronoxUserModel).refreshToken);
        locator<SharedPreferences>().setString(
          PreferenceTypes.school,
          school,
        );
        emit(state.copyWith(
            authStatus: AuthStatus.AUTHENTICATED, userSession: userRes.data!));
        break;
      case ApiStatus.ERROR:
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
    final secureStorage = locator<SecureStorageRepository>();
    final userRepository = locator<UserRepository>();

    final refreshToken = await secureStorage.getRefreshToken();

    if (refreshToken != null) {
      ApiResponse loggedInUser =
          await userRepository.getRefreshSession(refreshToken);

      switch (loggedInUser.status) {
        case ApiStatus.REQUESTED:
          emit(state.copyWith(
              authStatus: AuthStatus.AUTHENTICATED,
              userSession: loggedInUser.data!));
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
    locator<SecureStorageRepository>().clear();
    emit(state.copyWith(
        authStatus: AuthStatus.UNAUTHENTICATED, userSession: null));
  }

  bool get authenticated => state.authStatus == AuthStatus.AUTHENTICATED;
}
