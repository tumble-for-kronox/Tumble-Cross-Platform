import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/database/shared_preference_response.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/shared/app_dependencies.dart';

import '../../api/notifications/repository/notification_repository.dart';

part 'app_switch_state.dart';

class AppSwitchCubit extends Cubit<AppSwitchState> {
  AppSwitchCubit()
      : super(const AppSwitchState(status: AppSwitchStatus.INITIAL)) {
    _init();
  }

  final _cacheAndInteractionService = getIt<CacheRepository>();
  final _databaseService = getIt<DatabaseRepository>();
  final _appDependencies = getIt<AppDependencies>();
  final _notificationService = getIt<NotificationRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  bool get schoolNotNull => _preferenceService.defaultSchool != null;

  Future<void> _init() async {
    SharedPreferenceResponse sharedPreferenceResponse =
        await _cacheAndInteractionService.hasSchool();
    switch (sharedPreferenceResponse.status) {
      case SharedPreferenceSchoolStatus.INITIAL:
        emit(state.copyWith(status: AppSwitchStatus.UNINITIALIZED));
        break;
      case SharedPreferenceSchoolStatus.SCHOOL_AVAILABLE:
        emit(state.copyWith(status: AppSwitchStatus.INITIALIZED));
        break;
    }
  }

  Future<void> permissionRequest(bool value) async {
    await _preferenceService.setNotificationAllowed(value);
    if (value) {
      await _notificationService.getPermission().then((_) async {
        await _notificationService.initialize();
        // Test notification trigger
        // await _notificationService.testNotification();
      });
    }
  }

  bool checkFirstTimeLaunch() => _preferenceService.hasRun;

  Future<void> setFirstTimeLaunched(bool hasRun) =>
      _preferenceService.setHasRun(hasRun);

  Future<void> changeSchool(String schoolName) async {
    /// Renew items in shared preferences
    await _appDependencies.updateDependencies(schoolName);

    /// Clear local db
    _databaseService.removeAll();
    _notificationService.cancelAllNotifications();
  }

  bool get notificationCheck =>
      getIt<PreferenceRepository>().allowedNotifications == null;
}
