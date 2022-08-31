import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';

@immutable
abstract class IBackendService {
  /// [HttpGet]
  Future<ApiScheduleOrProgrammeResponse> getRequestSchedule(
      String scheduleId, String defaultSchool);

  /// [HttpGet]
  Future<ApiScheduleOrProgrammeResponse> getPrograms(
      String searchQuery, String defaultSchool);

  /// [HttpGet]
  Future<ApiUserResponse> getUserEvents(
      String sessionToken, String defaultSchool);

  /// [HttpGet]
  Future<ApiUserResponse> getRefreshSession(
      String refreshToken, String defaultSchool);

  /// [HttpPost]
  Future<ApiUserResponse> postUserLogin(
      String username, String password, String defaultSchool);

  /// [HttpPut]
  Future<ApiUserResponse> putRegisterUserEvent(
      String eventId, String sessionToken, String defaultSchool);

  /// [HttpPut]
  Future<ApiUserResponse> putUnregisterUserEvent(
      String eventId, String sessionToken, String defaultSchool);

  /// [HttpPut]
  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(
      String sessionToken, String defaultSchool);

  /// [HttpPost]
  Future<ApiBugReportResponse> postSubmitIssue(
      String issueSubject, String issueBody);
}
