import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/user_repository.dart';
import 'package:tumble/database/repository/secure_storage_repository.dart';
import 'package:tumble/models/api_models/kronox_user_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState(status: AuthStatus.UNAUTHENTICATED)) {
    login();
  }

  Future<void> login() async {
    log("LOGIN CALLED");
    final secureStorage = locator<SecureStorageRepository>();
    final userRepository = locator<UserRepository>();

    final storedUsername = await secureStorage.getUsername();
    final storedPassword = await secureStorage.getPassword();

    if (storedUsername != null && storedPassword != null) {
      ApiResponse loggedInUser = await userRepository.postUserLogin(storedUsername, storedPassword);

      switch (loggedInUser.status) {
        case ApiStatus.REQUESTED:
          setUserSession(loggedInUser.data!);
          log("Successfully logged in user: ${loggedInUser.data}");
          break;
        default:
          log("Failed to login user.");
          return;
      }
    }
  }

  void setUserSession(KronoxUserModel user) {
    emit(state.copyWith(status: AuthStatus.AUTHENTICATED, userSession: user));
  }

  void logout() => emit(state.copyWith(status: AuthStatus.UNAUTHENTICATED, userSession: null));
}
