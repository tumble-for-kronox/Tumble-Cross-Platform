// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/api/interface/iimplementation_service.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

class ImplementationRepository implements IImplementationService {
  final _backendService = locator<BackendRepository>();
  final _databaseService = locator<DatabaseRepository>();

  @override
  Future<ApiResponse> getProgramsRequest(String searchQuery) async {
    String defaultSchool = await _databaseService.getDefaultSchool();
    ApiResponse response =
        await _backendService.getPrograms(searchQuery, defaultSchool);
    return response;
  }

  @override
  Future<ApiResponse> getSchedulesRequest(scheduleId) async {
    String defaultSchool = await _databaseService.getDefaultSchool();
    ApiResponse response = await _backendService.getSchedule(
        scheduleId, "startOfWeek", defaultSchool);
    return response;
  }

  @override
  Future<dynamic> getSchedule(String scheduleId) async {
    final ScheduleData? _possibleSchedule =
        await _databaseService.getScheduleEntry(scheduleId);
    if (_possibleSchedule != null) {
      final ScheduleModel _schedule =
          scheduleModelFromJson(_possibleSchedule.jsonString);
      return _schedule;
    }
    return getSchedulesRequest(scheduleId);
  }

  @override
  Future<DatabaseResponse> initSetup() async {
    final bool _hasFavoriteSchedule =
        await _databaseService.hasFavoriteSchedule();
    final bool _hasDefaultSchool = await _databaseService.hasDefaultSchool();

    if (_hasFavoriteSchedule) {
      final String defaultSchedule =
          await _databaseService.currentDefaultSchedule();
      return DatabaseResponse.hasFavorite(defaultSchedule);
    } else if (_hasDefaultSchool) {
      final String defaultSchool = await _databaseService.getDefaultSchool();
      return DatabaseResponse.hasDefaut(defaultSchool);
    } else {
      return DatabaseResponse.initial("Init application preferences");
    }
  }

  void setupSchoolReset(String school) async {
    if ((await _databaseService.getPreferences() != null)) {
      _databaseService.updatePreferences(school);
    } else {
      _databaseService.addPreferences(PreferenceData(
          defaultSchool: school,
          viewType: 0,
          theme: '',
          preferenceId: 1,
          notificationTime: '',
          defaultSchedule: ''));
    }
  }
}
