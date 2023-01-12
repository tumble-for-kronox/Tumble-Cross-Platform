import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/api/backend/data/constants.dart';
import 'package:tumble/core/api/backend/repository/backend_service.dart';
import 'package:tumble/core/api/database/repository/database_service.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/shared/app_dependencies.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class CacheService {
  final _backendService = getIt<BackendService>();
  final _preferenceService = getIt<SharedPreferenceService>();
  final _databaseService = getIt<DatabaseService>();
  final _appDependencies = getIt<AppDependencies>();
  final _notificationService = getIt<NotificationService>();

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
    // Check if the schedule is in the user's bookmarks
    final bool bookmarksContainsThisScheduleId =
        _preferenceService.bookmarksHasId(scheduleId);
    if (bookmarksContainsThisScheduleId) {
      // Get the cached version of the schedule
      final ScheduleModel? userCachedSchedule =
          await _getCachedSchedule(scheduleId);

      if (userCachedSchedule == null) {
        // Try to fetch new version of schedule if the cache is empty
        final ApiResponse apiResponse = await updateSchedule(scheduleId);
        if (apiResponse.data == null) {
          return ApiResponse.error(RuntimeErrorType.scheduleFetchError(),
              S.popUps.scheduleFetchError());
        }
        return apiResponse;
      }

      // Check if the cached schedule is more than 2 hours old
      if (DateTime.now()
          .subtract(const Duration(hours: 2))
          .isAfter(userCachedSchedule.cachedAt.toLocal())) {
        // Try to fetch new version of schedule if it is outdated
        ApiResponse apiResponse = await updateSchedule(scheduleId);
        if (apiResponse.data != null) {
          return apiResponse;
        }
      }

      // Return the cached schedule if it is still valid
      return ApiResponse.cached(userCachedSchedule);
    }

    // Fetch the schedule from the backend if it is not in the user's bookmarks
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
      getIt<SharedPreferenceService>().allowedNotifications == null;
}
