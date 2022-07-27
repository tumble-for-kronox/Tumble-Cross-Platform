import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tumble/api/apiservices/api_endpoints.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/apiservices/fetch_response.dart';
import 'package:tumble/api/cert_bypass.dart';
import 'package:tumble/api/interface/ibackend_service.dart';
import 'package:http/http.dart' as http;
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/ui/main_app_widget/data/schools.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiResponse> getSchedule(
      String scheduleId, String defaultSchool) async {
    final school = (Schools.schools
            .where((school) => school.schoolName == defaultSchool)
            .single)
        .schoolId
        .index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl,
          '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school.toString(),
      });
      final response = await HttpService.sendRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return response.parseSchedule();
    } else {
      var uri = Uri.https(
          ApiEndPoints.baseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school,
      });
      final response = await compute(http.get, uri);
      return response.parseSchedule();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiResponse> getPrograms(
      String searchQuery, String defaultSchool) async {
    final school = (Schools.schools
            .where((school) => school.schoolName == defaultSchool)
            .single)
        .schoolId
        .index;

    if (kDebugMode) {
      var uri = Uri.https(
          ApiEndPoints.debugBaseUrl, ApiEndPoints.getSchedules, {
        ApiEndPoints.search: searchQuery,
        ApiEndPoints.school: school.toString()
      });
      final response = await HttpService.sendRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return await response.parsePrograms();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules, {
        ApiEndPoints.search: searchQuery,
        ApiEndPoints.school: school.toString()
      });
      final response = await compute(http.get, uri);
      return response.parsePrograms();
    }
    // final response = await compute(http.get, uri);
  }
}
