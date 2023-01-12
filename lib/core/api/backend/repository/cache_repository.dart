import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/api/backend/data/constants.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/shared/app_dependencies.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class CacheRepository {
  final _backendService = getIt<BackendRepository>();
  final _preferenceService = getIt<PreferenceRepository>();
  final _databaseService = getIt<DatabaseRepository>();
  final _appDependencies = getIt<AppDependencies>();
  final _notificationService = getIt<NotificationRepository>();

  
  Future<ApiResponse> searchProgram(String searchQuery) async {
    String defaultSchool = _preferenceService.defaultSchool!;
    ApiResponse response =
        await _backendService.getPrograms(searchQuery, defaultSchool);
    return response;
  }

  
  Future<ApiResponse> updateSchedule(scheduleId) async {
    String defaultSchool = _preferenceService.defaultSchool!;
    ApiResponse response =
        await _backendService.getSchedule(scheduleId, defaultSchool);
    return response;
  }

  
  Future<ApiResponse> findSchedule(String scheduleId) async {
    final bool bookmarksContainsThisScheduleId =
        _preferenceService.bookmarksHasId(scheduleId);
    if (bookmarksContainsThisScheduleId) {
      final ScheduleModel? userCachedSchedule =
          await _getCachedSchedule(scheduleId);

      if (userCachedSchedule == null) {
        /// Try to fetch new version of schedule if the cache is empty
        final ApiResponse apiResponse = await updateSchedule(scheduleId);
        if (apiResponse.data == null) {
          return ApiResponse.error(RuntimeErrorType.scheduleFetchError(),
              S.popUps.scheduleFetchError());
        }
        return apiResponse;
      }

      /// If the schedule is more than 2 hours
      if (DateTime.now()
          .subtract(Constants.updateOffset)
          .isAfter(userCachedSchedule.cachedAt.toLocal())) {
        /// Make sure that only if the user has an internet connection and the
        /// schedule is 'outdated', the app will display the new schedule.
        /// Otherwise it returns [ApiResponse.cached(userCachedSchedule)]
        ApiResponse apiResponse = await updateSchedule(scheduleId);
        if (apiResponse.data != null) {
          return apiResponse;
        }
      }

      /// If the userCachedSchedule is not null and the schedule does not
      /// need to be updated, return the cache
      return ApiResponse.cached(userCachedSchedule);
    }

    /// Fetch from backend if the bookmark is not available in
    /// preferences.
    return await updateSchedule(scheduleId);
  }

  Future<ScheduleModel?> _getCachedSchedule(String scheduleId) async {
    return (await _databaseService.getOneSchedule(scheduleId));
  }

  
  bool get schoolNotNull => _preferenceService.defaultSchool != null;

  
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
