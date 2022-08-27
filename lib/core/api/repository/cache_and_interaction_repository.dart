import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/interface/icache_and_interaction_service.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/database/database_response.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class CacheAndInteractionRepository implements ICacheAndInteractionService {
  final _backendService = getIt<BackendRepository>();
  final _preferenceService = getIt<SharedPreferences>();
  final _databaseService = getIt<DatabaseRepository>();

  @override
  Future<ApiResponse> getProgramsRequest(String searchQuery) async {
    String defaultSchool =
        _preferenceService.getString(PreferenceTypes.school)!;
    ApiResponse response =
        await _backendService.getPrograms(searchQuery, defaultSchool);
    return response;
  }

  @override
  Future<ApiResponse> getSchedulesRequest(scheduleId) async {
    /// User cannot get this far in the app without having a default
    /// school stored, therefore null check operator is OK
    String defaultSchool =
        _preferenceService.getString(PreferenceTypes.school)!;
    ApiResponse response =
        await _backendService.getSchedule(scheduleId, defaultSchool);
    return response;
  }

  @override
  Future<ApiResponse> getSchedule(String scheduleId) async {
    final bool favoritesContainsThisScheduleId = _preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .contains(scheduleId);

    if (favoritesContainsThisScheduleId) {
      final ScheduleModel userCachedSchedule =
          await _getCachedSchedule(scheduleId);

      // if (DateTime.now().subtract(const Duration(minutes: 30)).isAfter(userCachedSchedule.cachedAt.toLocal())) {
      //   return await getSchedule(scheduleId);
      // }

      return ApiResponse.cached(userCachedSchedule);
    }

    /// fetch from backend
    return await getSchedulesRequest(scheduleId);
  }

  /// Returns appropriate response based on the users
  /// current use state in the app (if they just opened it,
  /// have at least a default school or even a default school
  /// and a default schedule)
  @override
  Future<DatabaseResponse> initSetup() async {
    final String? defaultSchool =
        _preferenceService.getString(PreferenceTypes.school);

    if (defaultSchool != null) {
      return DatabaseResponse.hasDefault(defaultSchool);
    } else {
      return DatabaseResponse.initial("Init application preferences");
    }
  }

  @override
  Future<ApiResponse> getCachedBookmarkedSchedule() async {
    final bool userHasCachedSchedule =
        _preferenceService.getString(PreferenceTypes.schedule) != null;
    if (userHasCachedSchedule) {
      ScheduleModel userCachedSchedule = await _getCachedSchedule(null);
      return ApiResponse.cached(userCachedSchedule);
    }
    return ApiResponse.error(RuntimeErrorType.noCachedSchedule);
  }

  Future<ScheduleModel> _getCachedSchedule(String? scheduleId) async {
    return (await _databaseService.getOneSchedule(scheduleId ??
        _preferenceService.getString(PreferenceTypes.schedule)!))!;
  }

  @override
  Future<ApiResponse> refreshDefaultSchedule() async {
    String defaultScheduleId =
        _preferenceService.getString(PreferenceTypes.schedule)!;
    return await getSchedulesRequest(defaultScheduleId);
  }
}
