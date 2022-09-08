import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';

part 'user_event_state.dart';

/// Handles user events and resource booking
class UserEventCubit extends Cubit<UserEventState> {
  UserEventCubit()
      : super(UserEventState(
          userEventListStatus: UserOverviewStatus.INITIAL,
          autoSignup:
              getIt<SharedPreferences>().getBool(PreferenceTypes.autoSignup)!,
        ));

  final _userRepo = getIt<UserRepository>();

  Future<void> getUserEvents(
      AuthStatus authStatus, KronoxUserModel? userSession) async {
    switch (authStatus) {
      case AuthStatus.AUTHENTICATED:
        log('HERE');
        emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
        ApiUserResponse userEventResponse =
            await _userRepo.getUserEvents(userSession!.sessionToken);
        log(userEventResponse.status.name);
        switch (userEventResponse.status) {
          case ApiUserResponseStatus.COMPLETED:
            emit(state.copyWith(
              userEventListStatus: UserOverviewStatus.LOADED,
              userEvents: userEventResponse.data!,
            ));
            break;
          case ApiUserResponseStatus.ERROR:
            emit(state);
            break;
          default:
            emit(state.copyWith(
              userEventListStatus: UserOverviewStatus.ERROR,
            ));
        }
        break;
      default:
        break;
    }
  }

  Future<void> registerUserEvent(
      String id, AuthStatus authStatus, KronoxUserModel? userSession) async {
    emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
    ApiUserResponse registerResponse =
        await _userRepo.putRegisterUserEvent(id, userSession!.sessionToken);
    log(registerResponse.status.name);
    switch (registerResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        getUserEvents(authStatus, userSession);
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        emit(state.copyWith(
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.loginError()));
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        emit(state.copyWith(
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> unregisterUserEvent(
      String id, AuthStatus authStatus, KronoxUserModel? userSession) async {
    emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
    ApiUserResponse unregisterResponse =
        await _userRepo.putUnregisterUserEvent(id, userSession!.sessionToken);

    switch (unregisterResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        getUserEvents(authStatus, userSession);
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        emit(state.copyWith(
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.loginError()));
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        emit(state.copyWith(
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> autoSignupToggle(bool value) async {
    getIt<SharedPreferences>().setBool(PreferenceTypes.autoSignup, value);
    emit(state.copyWith(autoSignup: value));
  }
}
