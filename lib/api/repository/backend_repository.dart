import 'package:flutter/foundation.dart';
import 'package:tumble/api/apiservices/api_endpoints.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/interface/ibackend_service.dart';
import 'package:http/http.dart' as http;
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/ui/home_page_widget/data/schools.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiResponse> getSchedule(
      String scheduleId, String startTag, String defaultSchool) async {
    final school = (Schools.schools
            .where((school) => school.schoolName == defaultSchool)
            .single)
        .schoolId
        .name;
    var uri = Uri.https(
        ApiEndPoints.baseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
      ApiEndPoints.school: school, // Empty for now
      ApiEndPoints.startTag: startTag
    });
    final response = await compute(http.get, uri);
    return response.parseSchedule();
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
    var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules, {
      ApiEndPoints.search: searchQuery,
      ApiEndPoints.school: school.toString()
    });
    final response = await compute(http.get, uri);
    return response.parseProgram();
  }
}
