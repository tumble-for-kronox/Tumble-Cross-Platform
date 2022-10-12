import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/data/constants.dart';
import 'package:tumble/core/api/backend/interface/icache_service.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/database/shared_preference_response.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class CacheRepository implements ICacheService {
  final _backendService = getIt<BackendRepository>();
  final _preferenceService = getIt<PreferenceRepository>();
  final _databaseService = getIt<DatabaseRepository>();

  @override
  Future<ScheduleOrProgrammeResponse> searchProgram(String searchQuery) async {
    String defaultSchool = _preferenceService.defaultSchool!;
    ScheduleOrProgrammeResponse response = await _backendService.getPrograms(searchQuery, defaultSchool);
    return response;
  }

  @override
  Future<ScheduleOrProgrammeResponse> updateSchedule(scheduleId) async {
    String defaultSchool = _preferenceService.defaultSchool!;
    ScheduleOrProgrammeResponse response = await _backendService.getSchedule(scheduleId, defaultSchool);
    return response;
  }

  @override
  Future<ScheduleOrProgrammeResponse> findSchedule(String scheduleId) async {
    final bool bookmarksContainsThisScheduleId = _preferenceService.bookmarksHasId(scheduleId);

    if (bookmarksContainsThisScheduleId) {
      final ScheduleModel? userCachedSchedule = await _getCachedSchedule(scheduleId);

      /// If the schedule for some reason is not found in the database,
      /// or if the schedule is more than 30 minutes old
      if (userCachedSchedule == null ||
          DateTime.now().subtract(Constants.updateOffset).isAfter(userCachedSchedule.cachedAt.toLocal())) {
        /// Make sure that only if the user has an internet connection and the
        /// schedule is 'outdated', the app will display the new schedule.
        /// Otherwise it returns [ApiResponse.cached(userCachedSchedule)]
        ScheduleOrProgrammeResponse apiResponse = await updateSchedule(scheduleId);
        if (apiResponse.data != null) {
          return apiResponse;
        } else if (userCachedSchedule != null) {
          return ScheduleOrProgrammeResponse.cached(userCachedSchedule);
        }
        return ScheduleOrProgrammeResponse.error(RuntimeErrorType.scheduleFetchError(), S.popUps.scheduleFetchError());
      }

      return ScheduleOrProgrammeResponse.cached(userCachedSchedule);
    }

    /// fetch from backend
    return await updateSchedule(scheduleId);
  }

  /// Returns appropriate response based on the users
  /// current use state in the app (if they just opened it,
  /// have at least a default school or even a default school
  /// and a default schedule)
  @override
  Future<SharedPreferenceResponse> hasSchool() async {
    final String? defaultSchool = _preferenceService.defaultSchool;

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
