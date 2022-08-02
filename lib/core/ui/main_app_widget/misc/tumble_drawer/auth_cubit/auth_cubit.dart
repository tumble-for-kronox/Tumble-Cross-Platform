import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState(status: AuthStatus.INITIAL)) {
    login();
  }

  Future<void> login() async {
    emit(state.copyWith(status: AuthStatus.INITIAL));
    final secureStorage = locator<SecureStorageRepository>();
    final userRepository = locator<UserRepository>();

    final refreshToken = await secureStorage.getRefreshToken();

    if (refreshToken != null) {
      ApiResponse loggedInUser =
          await userRepository.getRefreshSession(refreshToken);

      switch (loggedInUser.status) {
        case ApiStatus.REQUESTED:
          setUserSession(loggedInUser.data!);
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
    locator<SecureStorageRepository>().clear();
    emit(
        const AuthState(status: AuthStatus.UNAUTHENTICATED, userSession: null));
  }

  bool get authenticated => state.status == AuthStatus.AUTHENTICATED;
}
