import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumble/core/api/backend/repository/backend_service.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/user_event_collection_model.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';

part 'user_event_state.dart';

/// Handles user events and resource booking
class UserEventCubit extends Cubit<UserEventState> {
  UserEventCubit()
      : super(UserEventState(
          userEventListStatus: UserOverviewStatus.initial,
          registerUnregisterStatus: RegistrationStatus.initial,
          autoSignup: getIt<SharedPreferenceService>().autoSignup!,
        ));

  final _preferenceService = getIt<SharedPreferenceService>();
  final _backendRepository = getIt<BackendService>();

  String get defaultSchool => getIt<SharedPreferenceService>().defaultSchool!;

  Future<void> getUserEvents(
      AuthStatus status, Function logOut, bool showLoading) async {
    switch (status) {
      case AuthStatus.authenticated:
        if (showLoading) {
          emit(state.copyWith(userEventListStatus: UserOverviewStatus.loading));
        }
        ApiResponse apiResponse =
            await _backendRepository.getUserEvents(defaultSchool);

        switch (apiResponse.status) {
          case ApiResponseStatus.completed:
            if (isClosed) {
              return;
            }
            emit(state.copyWith(
              userEventListStatus: UserOverviewStatus.loaded,
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
              userEventListStatus: UserOverviewStatus.error,
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
    emit(state.copyWith(registerUnregisterStatus: RegistrationStatus.loading));
    ApiResponse apiResponse =
        await _backendRepository.putRegisterUserEvent(defaultSchool, id);

    switch (apiResponse.status) {
      case ApiResponseStatus.completed:
      case ApiResponseStatus.success:
        await getUserEvents(status, logOut, false);
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegistrationStatus.initial));
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      case ApiResponseStatus.error:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegistrationStatus.initial,
            userEventListStatus: UserOverviewStatus.error,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
        break;
      default:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            registerUnregisterStatus: RegistrationStatus.initial,
            userEventListStatus: UserOverviewStatus.error,
            errorMessage: RuntimeErrorType.failedExamSignUp()));
    }
  }

  Future<void> unregisterUserEvent(
      String id, AuthStatus status, Function logOut) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(registerUnregisterStatus: RegistrationStatus.loading));
    ApiResponse apiResponse =
        await _backendRepository.putUnregisterUserEvent(defaultSchool, id);

    if (isClosed) {
      return;
    }

    switch (apiResponse.status) {
      case ApiResponseStatus.completed:
      case ApiResponseStatus.success:
        await getUserEvents(status, logOut, false);
        emit(state.copyWith(
            registerUnregisterStatus: RegistrationStatus.initial));
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      default:
        emit(state.copyWith(
            registerUnregisterStatus: RegistrationStatus.initial,
            userEventListStatus: UserOverviewStatus.error,
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
