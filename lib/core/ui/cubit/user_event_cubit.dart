import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/repository/user_action_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/user_event_collection_model.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';

part 'user_event_state.dart';

/// Handles user events and resource booking
class UserEventCubit extends Cubit<UserEventState> {
  UserEventCubit()
      : super(UserEventState(
          userEventListStatus: UserOverviewStatus.INITIAL,
          registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
          autoSignup: getIt<PreferenceRepository>().autoSignup!,
        ));

  final _userActionService = getIt<UserActionRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  Future<void> getUserEvents(AuthStatus status, Function login, Function logOut, String sessionToken, bool showLoading,
      {bool loginLooped = false}) async {
    switch (status) {
      case AuthStatus.AUTHENTICATED:
        if (showLoading) emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
        UserResponse userEventResponse = await _userActionService.userEvents(sessionToken);
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
              await login();
              await getUserEvents(status, login, logOut, sessionToken, true, loginLooped: true);
            } else {
              logOut();
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

  Future<void> registerUserEvent(AuthStatus status, String id, Function logOut, Function login, String sessionToken,
      {bool loginLooped = false}) async {
    emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    UserResponse registerResponse = await _userActionService.registerUserEvent(id, sessionToken);
    switch (registerResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        await getUserEvents(status, login, logOut, sessionToken, false);
        emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await login();
          await registerUserEvent(status, id, logOut, login, sessionToken, loginLooped: true);
        } else {
          logOut();
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

  Future<void> unregisterUserEvent(String id, AuthStatus status, Function login, String sessionToken, Function logOut, {bool loginLooped = false}) async {
    emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    UserResponse unregisterResponse =
        await _userActionService.unregisterUserEvent(id, sessionToken);

    switch (unregisterResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        await getUserEvents(status, login, logOut, sessionToken, false);
        emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await login();
          await unregisterUserEvent(id, status, login, sessionToken, logOut, loginLooped: true);
        } else {
          logOut();
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
    _preferenceService.setAutoSignup(value);
    emit(state.copyWith(autoSignup: value));
  }

  void changeCurrentTabIndex(int newIndex) {
    emit(state.copyWith(currentTabIndex: newIndex));
  }
}
