import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/interface/icache_and_interaction_service.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/database/database_response.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class CacheAndInteractionRepository implements ICacheAndInteractionService {
  final _backendService = getIt<BackendRepository>();
  final _preferenceService = getIt<SharedPreferences>();
  final _databaseService = getIt<DatabaseRepository>();

  @override
  Future<ApiScheduleOrProgrammeResponse> programSearchDispatcher(String searchQuery) async {
    String defaultSchool = _preferenceService.getString(PreferenceTypes.school)!;
    ApiScheduleOrProgrammeResponse response = await _backendService.getPrograms(searchQuery, defaultSchool);
    return response;
  }

  @override
  Future<ApiScheduleOrProgrammeResponse> scheduleFetchDispatcher(scheduleId) async {
    String defaultSchool = _preferenceService.getString(PreferenceTypes.school)!;
    ApiScheduleOrProgrammeResponse response = await _backendService.getRequestSchedule(scheduleId, defaultSchool);
    return response;
  }

  @override
  Future<ApiScheduleOrProgrammeResponse> getCachedOrNewSchedule(String scheduleId) async {
    final bool bookmarksContainsThisScheduleId = _preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
        .contains(scheduleId);

    if (bookmarksContainsThisScheduleId) {
      final ScheduleModel? userCachedSchedule = await _getCachedSchedule(scheduleId);

      /// If the schedule for some reason is not found in the database,
      /// or if the schedule is more than 30 minutes old
      if (userCachedSchedule == null ||
          DateTime.now().subtract(const Duration(minutes: 30)).isAfter(userCachedSchedule.cachedAt.toLocal())) {
        /// Make sure that only if the user has an internet connection and the
        /// schedule is 'outdated', the app will display the new schedule.
        /// Otherwise it returns [ApiResponse.cached(userCachedSchedule)]
        ApiScheduleOrProgrammeResponse apiResponse = await scheduleFetchDispatcher(scheduleId);
        if (apiResponse.data != null) {
          return apiResponse;
        } else if (userCachedSchedule != null) {
          return ApiScheduleOrProgrammeResponse.cached(userCachedSchedule);
        }
        return ApiScheduleOrProgrammeResponse.error(RuntimeErrorType.scheduleFetchError());
      }

      return ApiScheduleOrProgrammeResponse.cached(userCachedSchedule);
    }

    /// fetch from backend
    return await scheduleFetchDispatcher(scheduleId);
  }

  /// Returns appropriate response based on the users
  /// current use state in the app (if they just opened it,
  /// have at least a default school or even a default school
  /// and a default schedule)
  @override
  Future<SharedPreferenceResponse> verifyDefaultSchoolExists() async {
    final String? defaultSchool = _preferenceService.getString(PreferenceTypes.school);

    if (defaultSchool != null) {
      return SharedPreferenceResponse.schoolAvailable(defaultSchool);
    } else {
      return SharedPreferenceResponse.noSchool("School unavailable");
    }
  }

  Future<ScheduleModel?> _getCachedSchedule(String scheduleId) async {
    return (await _databaseService.getOneSchedule(scheduleId));
  }
}
