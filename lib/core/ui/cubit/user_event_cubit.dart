import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
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

  Future<void> getUserEvents(
      AuthStatus status, Function logOut, bool showLoading) async {
    switch (status) {
      case AuthStatus.AUTHENTICATED:
        if (showLoading) {
          emit(state.copyWith(userEventListStatus: UserOverviewStatus.LOADING));
        }
        ApiResponse apiResponse = await _userActionService.userEvents();

        switch (apiResponse.status) {
          case ApiResponseStatus.completed:
            if (isClosed) {
              return;
            }
            emit(state.copyWith(
              userEventListStatus: UserOverviewStatus.LOADED,
              userEvents: apiResponse.data!,
            ));
            break;
          case ApiResponseStatus.error:
            if (isClosed) {
              return;
            }
            emit(state);
            break;
          case ApiResponseStatus.unauthorized:
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

  Future<void> registerUserEvent(
      AuthStatus status, String id, Function logOut) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(
        registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    ApiResponse apiResponse = await _userActionService.registerUserEvent(id);

    switch (apiResponse.status) {
      case ApiResponseStatus.completed:
      case ApiResponseStatus.success:
        await getUserEvents(status, logOut, false);
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      case ApiResponseStatus.error:
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

  Future<void> unregisterUserEvent(
      String id,
      AuthStatus status,
      void Function(KronoxUserModel) setAuthSession,
      Function logOut,
      KronoxUserModel session) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(
        registerUnregisterStatus: RegisterUnregisterStatus.LOADING));
    ApiResponse apiResponse = await _userActionService.unregisterUserEvent(id);

    switch (apiResponse.status) {
      case ApiResponseStatus.completed:
      case ApiResponseStatus.success:
        await getUserEvents(status, logOut, false);
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegisterUnregisterStatus.INITIAL));
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      case ApiResponseStatus.error:
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
