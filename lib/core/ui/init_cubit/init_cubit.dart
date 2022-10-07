import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/repository/cache_and_interaction_repository.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/database/database_response.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/shared/app_dependencies.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit()
      : super(const InitState(
            defaultSchool: null, status: InitStatus.NO_SCHOOL)) {
    _init();
  }

  final _cacheAndInteractionService = getIt<CacheAndInteractionRepository>();
  final _databaseService = getIt<DatabaseRepository>();
  final _appDependencies = getIt<AppDependencies>();
  final _notificationService = getIt<NotificationRepository>();

  Future<void> _init() async {
    SharedPreferenceResponse sharedPreferenceResponse =
        await _cacheAndInteractionService.verifyDefaultSchoolExists();
    switch (sharedPreferenceResponse.status) {
      case InitialStatus.NO_SCHOOL:
        emit(
            const InitState(defaultSchool: null, status: InitStatus.NO_SCHOOL));
        break;
      case InitialStatus.SCHOOL_AVAILABLE:
        String defaultSchool = sharedPreferenceResponse.data;
        emit(InitState(
            defaultSchool: defaultSchool, status: InitStatus.SCHOOL_AVAILABLE));
        break;
    }
  }

  Future<void> changeSchool(String schoolName) async {
    /// Renew items in shared preferences
    await _appDependencies.updateDependencies(schoolName);

    if (state.status == InitStatus.SCHOOL_AVAILABLE) {
      /// Clear local db
      _databaseService.removeAll();
      _databaseService.removeAllCachedCourseColors();
      _notificationService.cancelAllNotifications();

      emit(state.copyWith(defaultSchool: schoolName));
      return;
    } else if (state.status == InitStatus.NO_SCHOOL) {
      emit(state.copyWith(
          defaultSchool: schoolName, status: InitStatus.SCHOOL_AVAILABLE));
    }
  }
}
