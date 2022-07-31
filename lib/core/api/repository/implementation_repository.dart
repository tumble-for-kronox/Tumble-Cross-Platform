// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/interface/iimplementation_service.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/database/database_response.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

class ImplementationRepository implements IImplementationService {
  final _backendService = locator<BackendRepository>();
  final _preferenceService = locator<SharedPreferences>();
  final _databaseService = locator<DatabaseRepository>();

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
    /// school, therefore null check is OK
    String defaultSchool =
        _preferenceService.getString(PreferenceTypes.school)!;
    ApiResponse response =
        await _backendService.getSchedule(scheduleId, defaultSchool);
    return response;
  }

  @override
  Future<ApiResponse> getSchedule(String scheduleId) async {
    if (_preferenceService
        .getStringList(PreferenceTypes.favorites)!
        .contains(scheduleId)) {
      final ScheduleModel? _possibleSchedule =
          await _databaseService.getOneSchedule(scheduleId);
      return ApiResponse.cached(_possibleSchedule);
    }
    return await getSchedulesRequest(scheduleId);
  }

  /// Returns appropriate response based on the users
  /// current use state in the app (if they just opened it,
  /// have at least a default school or even a default school
  /// and a default schedule)
  @override
  Future<DatabaseResponse> initSetup() async {
    final String? _defaultSchool =
        _preferenceService.getString(PreferenceTypes.school);

    if (_defaultSchool != null) {
      return DatabaseResponse.hasDefault(_defaultSchool);
    } else {
      return DatabaseResponse.initial("Init application preferences");
    }
  }

  @override
  Future<ApiResponse> getCachedBookmarkedSchedule() async {
    if (_preferenceService.getString(PreferenceTypes.schedule) != null) {
      final ScheduleModel? _possibleSchedule =
          await _databaseService.getOneSchedule(
              _preferenceService.getString(PreferenceTypes.schedule)!);
      return ApiResponse.cached(_possibleSchedule);
    }
    return ApiResponse.error('No cached schedule found');
  }
}
