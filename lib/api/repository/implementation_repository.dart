// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/api/interface/iimplementation_service.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

class ImplementationRepository implements IImplementationService {
  final _backendService = locator<BackendRepository>();
  final _preferenceService = locator<SharedPreferences>();

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
    ApiResponse response = await _backendService.getSchedule(
        scheduleId, "startOfWeek", defaultSchool);
    return response;
  }

  @override
  Future<ApiResponse> getSchedule(String scheduleId) async {
    String pretend = await rootBundle.loadString('pretend_struct.json');
    return ApiResponse.completed(scheduleModelFromJson(pretend));

    /* final ScheduleData? _possibleSchedule =
        await _databaseService.getScheduleEntry(scheduleId);
    if (_possibleSchedule != null) {
      final ScheduleModel _schedule =
          scheduleModelFromJson(_possibleSchedule.jsonString);
      return _schedule;
    }
    return getSchedulesRequest(scheduleId); */
  }

  /// Returns appropriate response based on the users
  /// current use state in the app (if they just opened it,
  /// have at least a default school or even a default school
  /// and a default schedule)
  @override
  Future<DatabaseResponse> initSetup() async {
    final String? _defaultSchedule =
        _preferenceService.getString(PreferenceTypes.schedule);
    final String? _defaultSchool =
        _preferenceService.getString(PreferenceTypes.school);

    if (_defaultSchool != null) {
      return DatabaseResponse.hasDefault(_defaultSchool);
    } else if (_defaultSchool != null && _defaultSchedule != null) {
      return DatabaseResponse.hasFavorite(_defaultSchedule);
    } else {
      return DatabaseResponse.initial("Init application preferences");
    }
  }
}
