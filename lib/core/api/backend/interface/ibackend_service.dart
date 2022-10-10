import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/bug_report_response.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';

@immutable
abstract class IBackendService {
  /// [HttpGet]
  Future<ScheduleOrProgrammeResponse> getSchedule(String scheduleId, String defaultSchool);

  /// [HttpGet]
  Future<ScheduleOrProgrammeResponse> getPrograms(String searchQuery, String defaultSchool);

  /// [HttpGet]
  Future<UserResponse> getUserEvents(String sessionToken, String defaultSchool);

  /// [HttpGet]
  Future<UserResponse> getRefreshSession(String refreshToken, String defaultSchool);

  /// [HttpPost]
  Future<UserResponse> postUserLogin(String username, String password, String defaultSchool);

  /// [HttpPut]
  Future<UserResponse> putRegisterUserEvent(String eventId, String sessionToken, String defaultSchool);

  /// [HttpPut]
  Future<UserResponse> putUnregisterUserEvent(String eventId, String sessionToken, String defaultSchool);

  /// [HttpPut]
  Future<UserResponse> putRegisterAllAvailableUserEvents(String sessionToken, String defaultSchool);

  /// [HttpPost]
  Future<BugReportResponse> postSubmitIssue(String issueSubject, String issueBody);

  /// [HttpGet]
  Future<BookingResponse> getSchoolResources(String sessionToken, String defaultSchool);

  /// [HttpGet]
  Future<BookingResponse> getResourceAvailabilities(
      String sessionToken, String defaultSchool, String resourceId, DateTime date);

  /// [HttpGet]
  Future<BookingResponse> getUserBookings(String sessionToken, String defaultSchool);

  /// [HttpPut]
  Future<BookingResponse> putBookResource(
      String sessionToken, String defaultSchool, String resourceId, DateTime date, AvailabilityValue bookingSlot);

  /// [HttpPut]
  Future<BookingResponse> putUnbookResource(String sessionToken, String defaultSchool, String bookingId);

  /// [HttpPut]
  Future<BookingResponse> putConfirmBooking(
      String sessionToken, String defaultSchool, String resourceId, String bookingId);
}
