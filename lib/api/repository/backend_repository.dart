import 'package:flutter/foundation.dart';
import 'package:tumble/api/apiservices/api_endpoints.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/interface/ibackend_service.dart';
import 'package:http/http.dart' as http;
import 'package:tumble/extensions/extensions.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiResponse> getSchedule(
      String scheduleId, String startTag, String defaultSchool) async {
    var uri = Uri.https(
        ApiEndPoints.baseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
      'school': defaultSchool, // Empty for now
      'startTag': startTag
    });
    final response = await compute(http.get, uri);
    return response.parseSchedule();
  }

  /// [HttpGet]
  @override
  Future<ApiResponse> getPrograms(
      String searchQuery, String defaultSchool) async {
    var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
        {'search': searchQuery, 'school': 'hkr'});
    final response = await compute(http.get, uri);
    return response.parseProgram();
  }
}
