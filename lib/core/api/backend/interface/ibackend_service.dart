import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';

@immutable
abstract class IBackendService {
  /// [HttpGet]
  Future<ApiResponse> getSchedule(String scheduleId, String defaultSchool);

  /// [HttpGet]
  Future<ApiResponse> getPrograms(String searchQuery, String defaultSchool);

  /// [HttpGet]
  Future<ApiResponse> getUserEvents(String defaultSchool);

  /// [HttpGet]
  /* Future<ApiResponse> getRefreshSession(
      String refreshToken, String defaultSchool); */

  /// [HttpPost]
  Future<ApiResponse> postUserLogin(
      String username, String password, String defaultSchool);

  /// [HttpPut]
  Future<ApiResponse> putRegisterUserEvent(
      String eventId, String defaultSchool);

  /// [HttpPut]
  Future<ApiResponse> putUnregisterUserEvent(
      String eventId, String defaultSchool);

  /// [HttpPut]
  Future<ApiResponse> putRegisterAll(String defaultSchool);

  /// [HttpPost]
  Future<ApiResponse> postSubmitIssue(String issueSubject, String issueBody);

  /// [HttpGet]
  Future<ApiResponse> getSchoolResources(String defaultSchool);

  /// [HttpGet]
  Future<ApiResponse> getResourceAvailabilities(
      String defaultSchool, String resourceId, DateTime date);

  /// [HttpGet]
  Future<ApiResponse> getUserBookings(String defaultSchool);

  /// [HttpPut]
  Future<ApiResponse> putBookResource(String defaultSchool, String resourceId,
      DateTime date, AvailabilityValue bookingSlot);

  /// [HttpPut]
  Future<ApiResponse> putUnbookResource(String defaultSchool, String bookingId);

  /// [HttpPut]
  Future<ApiResponse> putConfirmBooking(
      String defaultSchool, String resourceId, String bookingId);
}
