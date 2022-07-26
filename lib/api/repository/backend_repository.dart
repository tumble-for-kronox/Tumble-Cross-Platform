import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tumble/api/apiservices/api_endpoints.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/cert_bypass.dart';
import 'package:tumble/api/interface/ibackend_service.dart';
import 'package:http/http.dart' as http;
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/models/api_models/program_model.dart';
import 'package:tumble/ui/home_page_widget/data/schools.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card.dart';

import '../../models/api_models/schedule_model.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiResponse<ScheduleModel>> getSchedule(String scheduleId, String defaultSchool) async {
    final school = (Schools.schools.where((school) => school.schoolName == defaultSchool).single).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school, // Empty for now
      });
      print(uri);
      final response = await HttpService.sendRequestToServer(uri);
      return response.parseSchedule();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school, // Empty for now
      });
      final response = await compute(http.get, uri);
      return response.parseSchedule();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiResponse<ProgramModel>> getPrograms(String searchQuery, String defaultSchool) async {
    final school = (Schools.schools.where((school) => school.schoolName == defaultSchool).single).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.search: searchQuery, ApiEndPoints.school: school.toString()});
      final response = await HttpService.sendRequestToServer(uri);
      return await response.parsePrograms();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.search: searchQuery, ApiEndPoints.school: school.toString()});
      final response = await http.get(uri);
      return await response.parsePrograms();
    }
    // final response = await compute(http.get, uri);
  }
}
