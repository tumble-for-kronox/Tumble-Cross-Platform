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

import '../../api/backend/response_types/refresh_response.dart';

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

  Future<void> getUserEvents(AuthStatus status, void Function(KronoxUserModel) setAuthSession, Function logOut,
      KronoxUserModel session, bool showLoading) async {
    switch (status) {
      case AuthStatus.AUTHENTICATED:
        if (showLoading) emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
        UserResponse userEventResponse = await _userActionService.userEvents();

        switch (userEventResponse.status) {
          case ApiUserResponseStatus.COMPLETED:
            if (isClosed) {
              return;
            }
            emit(state.copyWith(
              userEventListStatus: UserOverviewStatus.LOADED,
              userEvents: userEventResponse.data!,
            ));
            break;
          case ApiUserResponseStatus.ERROR:
            if (isClosed) {
              return;
            }
            emit(state);
            break;
          case ApiUserResponseStatus.UNAUTHORIZED:
            logOut();
            break;
          default:
            if (isClosed) {
              return;
            }
            emit(state.copyWith(
              userEventListStatus: UserOverviewStatus.ERROR,
            ));
        }
        break;
      default:
        break;
    }
  }

  Future<void> registerUserEvent(AuthStatus status, String id, void Function(KronoxUserModel) setAuthSession,
      Function logOut, KronoxUserModel session) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    UserResponse registerResponse = await _userActionService.registerUserEvent(id);

    switch (registerResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        await getUserEvents(status, setAuthSession, logOut, session, false);
        if (isClosed) {
          return;
        }
        emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      case ApiUserResponseStatus.ERROR:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> unregisterUserEvent(String id, AuthStatus status, void Function(KronoxUserModel) setAuthSession,
      Function logOut, KronoxUserModel session) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    UserResponse unregisterResponse = await _userActionService.unregisterUserEvent(id);

    switch (unregisterResponse.status) {
      case ApiUserResponseStatus.COMPLETED:
      case ApiUserResponseStatus.AUTHORIZED:
        await getUserEvents(status, setAuthSession, logOut, session, false);
        if (isClosed) {
          return;
        }
        emit(state.copyWith(registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiUserResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      case ApiUserResponseStatus.ERROR:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL,
            userEventListStatus: UserOverviewStatus.ERROR,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> autoSignupToggle(bool value) async {
    _preferenceService.setAutoSignup(value);
    if (isClosed) {
      return;
    }
    emit(state.copyWith(autoSignup: value));
  }

  void changeCurrentTabIndex(int newIndex) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(currentTabIndex: newIndex));
  }
}
