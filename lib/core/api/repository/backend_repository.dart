import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_booking_response.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/apiservices/api_endpoints.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/cert_bypass.dart';
import 'package:tumble/core/api/interface/ibackend_service.dart';
import 'package:tumble/core/extensions/api_response_extension/booking_parser.dart';
import 'package:tumble/core/extensions/api_response_extension/misc_parser.dart';
import 'package:tumble/core/extensions/api_response_extension/schedule_and_programme_parser.dart';
import 'package:tumble/core/extensions/api_response_extension/user_parser.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';

import '../../models/api_models/resource_model.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiScheduleOrProgrammeResponse> getRequestSchedule(String scheduleId, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school.toString(),
      });
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiScheduleOrProgrammeResponse.error(RuntimeErrorType.timeoutError());
      }
      return response.parseSchedule();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school,
      });
      final response = await compute(http.get, uri);
      return response.parseSchedule();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiScheduleOrProgrammeResponse> getPrograms(String searchQuery, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.search: searchQuery, ApiEndPoints.school: school.toString()});
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiScheduleOrProgrammeResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parsePrograms();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.search: searchQuery, ApiEndPoints.school: school.toString()});
      final response = await compute(http.get, uri);
      return response.parsePrograms();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiUserResponse> getUserEvents(String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getUserEvents,
          {ApiEndPoints.sessionToken: sessionToken, ApiEndPoints.school: school.toString()});
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiUserResponse.error(RuntimeErrorType.timeoutError());
      }

      return await response.parseUserEvents();
    } else {
      Uri uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.sessionToken: sessionToken, ApiEndPoints.school: school.toString()});
      final response = await compute(http.get, uri);
      return response.parseUserEvents();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiUserResponse> getRefreshSession(String refreshToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    Map<String, String> headers = {"Authorization": refreshToken};

    if (kDebugMode) {
      var uri = Uri.https(
        ApiEndPoints.debugBaseUrl,
        ApiEndPoints.getRefreshSession,
        {ApiEndPoints.school: school.toString()},
      );

      final response = await HttpService.sendGetRequestToServer(uri, headers: headers);
      if (response == null) {
        return ApiUserResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseUser();
    } else {
      var uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getRefreshSession,
        {ApiEndPoints.school: school.toString()},
      );

      final response = await http.get(uri, headers: headers);
      return response.parseUser();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiBookingResponse> getSchoolResources(String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getSchoolResources,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiBookingResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseSchoolResources();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchoolResources,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await http.get(uri);
      return response.parseSchoolResources();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiBookingResponse> getResourceAvailabilities(
      String sessionToken, String defaultSchool, String resourceId, DateTime date) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getResourceAvailability + resourceId, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
        ApiEndPoints.date: date.toIso8601String(),
      });

      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiBookingResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseSchoolResource();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getResourceAvailability + resourceId, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
        ApiEndPoints.date: date,
      });

      final response = await http.get(uri);
      return response.parseSchoolResource();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiBookingResponse> getUserBookings(String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getUserBookings, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
      });

      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiBookingResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseUserBookings();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getUserBookings, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
      });

      final response = await http.get(uri);
      return response.parseUserBookings();
    }
  }

  /// [HttpPut]
  @override
  Future<ApiUserResponse> putRegisterUserEvent(String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putRegisterEvent + eventId,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiUserResponse.error(RuntimeErrorType.timeoutError());
      }
      return response.parseRegisterOrUnregister();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules + eventId,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});
      final response = await http.put(uri);
      return response.parseRegisterOrUnregister();
    }
  }

  /// [HttpPut]
  @override
  Future<ApiUserResponse> putUnregisterUserEvent(String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putUnregisterEvent + eventId,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiUserResponse.error(RuntimeErrorType.timeoutError());
      }
      return response.parseRegisterOrUnregister();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules + eventId,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});
      final response = await http.put(uri);
      return response.parseRegisterOrUnregister();
    }
  }

  /// [HttpPut]
  @override
  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putRegisterAll,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});
      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiUserResponse.error(RuntimeErrorType.timeoutError());
      }
      return response.parseMultiRegistrationResult();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.putRegisterAll,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});
      final response = await http.put(uri);
      return response.parseMultiRegistrationResult();
    }
  }

  /// [HttpPut]
  @override
  Future<ApiBookingResponse> putBookResource(String sessionToken, String defaultSchool, String resourceId,
      DateTime date, AvailabilityValue bookingSlot) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> body = {
      ApiEndPoints.resourceId: resourceId,
      ApiEndPoints.date: date.toIso8601String(),
      ApiEndPoints.bookingSlot: bookingSlot,
    };

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putBookResource,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await HttpService.sendPutRequestToServer(uri, body: jsonEncode(body));
      if (response == null) {
        return ApiBookingResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseBookResource();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.putBookResource,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await http.put(uri, body: body);
      return response.parseBookResource();
    }
  }

  /// [HttpPut]
  @override
  Future<ApiBookingResponse> putUnbookResource(String sessionToken, String defaultSchool, String bookingId) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putUnbookResource, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
        ApiEndPoints.bookingId: bookingId
      });

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiBookingResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseUnbookResource();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.putUnbookResource, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
        ApiEndPoints.bookingId: bookingId
      });

      final response = await http.put(uri);
      return response.parseUnbookResource();
    }
  }

  /// [HttpPut]
  @override
  Future<ApiBookingResponse> putConfirmBooking(
      String sessionToken, String defaultSchool, String resourceId, String bookingId) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> body = {
      ApiEndPoints.resourceId: resourceId,
      ApiEndPoints.bookingId: bookingId,
    };

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putConfirmBooking, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
      });

      final response = await HttpService.sendPutRequestToServer(uri, body: jsonEncode(body));
      if (response == null) {
        return ApiBookingResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseConfirmBooking();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.putConfirmBooking, {
        ApiEndPoints.school: school.toString(),
        ApiEndPoints.sessionToken: sessionToken,
      });

      final response = await http.put(uri, body: body);
      return response.parseConfirmBooking();
    }
  }

  /// [HttpPost]
  @override
  Future<ApiUserResponse> postUserLogin(String username, String password, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, String> body = {ApiEndPoints.username: username, ApiEndPoints.password: password};
    if (kDebugMode) {
      var uri =
          Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.postUserLogin, {ApiEndPoints.school: school.toString()});

      final response = await HttpService.sendPostRequestToServer(uri, jsonEncode(body));
      if (response == null) {
        return ApiUserResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseUser();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules, {ApiEndPoints.school: school.toString()});
      final response = await http.post(uri, body: body);
      return response.parseUser();
    }
  }

  /// [HttpPost]
  @override
  Future<ApiBugReportResponse> postSubmitIssue(String issueSubject, String issueBody) async {
    final Map<String, String> requestBody = {
      ApiEndPoints.issueSubject: issueSubject,
      ApiEndPoints.issueBody: issueBody
    };
    if (kDebugMode) {
      var uri = Uri.https(
        ApiEndPoints.debugBaseUrl,
        ApiEndPoints.postSubmitIssue,
      );
      final response = await HttpService.sendPostRequestToServer(uri, jsonEncode(requestBody));

      if (response == null) {
        return ApiBugReportResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseIssue();
    } else {
      var uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.postSubmitIssue,
      );
      final response = await http.post(uri, body: requestBody);
      return response.parseIssue();
    }
  }
}
