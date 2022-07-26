// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/api/interface/iimplementation_service.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

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
    log(scheduleId);
    if (_preferenceService
        .getStringList(PreferenceTypes.favorites)!
        .contains(scheduleId)) {
      final ScheduleModel? _possibleSchedule =
          await _databaseService.getOneSchedule(scheduleId);
      log("${_possibleSchedule?.id}");
      return ApiResponse.completed(_possibleSchedule);
    }
    return await getSchedulesRequest(scheduleId);
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
