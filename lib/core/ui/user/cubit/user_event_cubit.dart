import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/repository/user_action_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/user_event_collection_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';

part 'user_event_state.dart';

/// Handles user events and resource booking
class UserEventCubit extends Cubit<UserEventState> {
  UserEventCubit()
      : super(UserEventState(
          userEventListStatus: UserOverviewStatus.INITIAL,
          registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
          autoSignup: getIt<SharedPreferences>().getBool(PreferenceTypes.autoSignup)!,
        ));

  final _userRepo = getIt<UserActionRepository>();

  Future<void> getUserEvents(AuthCubit authCubit, bool showLoding, {bool loginLooped = false}) async {
    switch (authCubit.state.status) {
      case AuthStatus.AUTHENTICATED:
        if (showLoding) emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
        UserResponse userEventResponse = await _userRepo.userEvents(authCubit.state.userSession!.sessionToken);
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
          case ApiUserResponseStatus.UNAUTHORIZED:
            if (!loginLooped) {
              await authCubit.login();
              await getUserEvents(authCubit, true, loginLooped: true);
            } else {
              authCubit.logout();
            }
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

  Future<void> registerUserEvent(String id, AuthCubit authCubit, {bool loginLooped = false}) async {
    emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    UserResponse registerResponse = await _userRepo.registerUserEvent(id, authCubit.state.userSession!.sessionToken);
    switch (registerResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        await getUserEvents(authCubit, false);
        emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          await registerUserEvent(id, authCubit, loginLooped: true);
        } else {
          authCubit.logout();
        }
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> unregisterUserEvent(String id, AuthCubit authCubit, {bool loginLooped = false}) async {
    emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    UserResponse unregisterResponse =
        await _userRepo.unregisterUserEvent(id, authCubit.state.userSession!.sessionToken);

    switch (unregisterResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        await getUserEvents(authCubit, false);
        emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          await unregisterUserEvent(id, authCubit, loginLooped: true);
        } else {
          authCubit.logout();
        }
        break;
      case ApiUserResponseStatus.ERROR:
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> autoSignupToggle(bool value) async {
    getIt<SharedPreferences>().setBool(PreferenceTypes.autoSignup, value);
    emit(state.copyWith(autoSignup: value));
  }

  void changeCurrentTabIndex(int newIndex) {
    emit(state.copyWith(currentTabIndex: newIndex));
  }
}
