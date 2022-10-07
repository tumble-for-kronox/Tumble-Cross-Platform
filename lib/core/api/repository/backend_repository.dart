import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/apiservices/api_booking_response.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/apiservices/api_endpoints.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/api/interface/ibackend_service.dart';
import 'package:tumble/core/extensions/api_response_extension/booking_parser.dart';
import 'package:tumble/core/extensions/api_response_extension/misc_parser.dart';
import 'package:tumble/core/extensions/api_response_extension/schedule_and_programme_parser.dart';
import 'package:tumble/core/extensions/api_response_extension/user_parser.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';

import '../../models/api_models/resource_model.dart';

class BackendRepository implements IBackendService {
  final dioHandle = Dio(BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ));

  /// [HttpGet]
  @override
  Future<ApiScheduleOrProgrammeResponse> getRequestSchedule(
      String scheduleId, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        '${ApiEndPoints.getOneSchedule}$scheduleId',
        {
          ApiEndPoints.school: school,
        }.map((key, value) => MapEntry(key, value.toString())));

    return await dioHandle
        .getUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseSchedule();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message');
      return ApiScheduleOrProgrammeResponse.error('Timed out');
    });
  }

  /// [HttpGet]
  @override
  Future<ApiScheduleOrProgrammeResponse> getPrograms(
      String searchQuery, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getSchedules,
        {
          ApiEndPoints.search: searchQuery,
          ApiEndPoints.school: school.toString()
        }.map((key, value) => MapEntry(key, value.toString())));

    return await dioHandle
        .getUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parsePrograms();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message');
      return ApiScheduleOrProgrammeResponse.error('Timed out');
    });
  }

  /// [HttpGet]
  @override
  Future<ApiUserResponse> getUserEvents(
      String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getUserEvents,
        {
          ApiEndPoints.sessionToken: sessionToken,
          ApiEndPoints.school: school.toString()
        }.map((key, value) => MapEntry(key, value.toString())));

    return await dioHandle
        .getUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseUserEvents();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [getUserEvents]');
      return ApiUserResponse.error('Timed out');
    });
  }

  /// [HttpGet]
  @override
  Future<ApiUserResponse> getRefreshSession(
      String refreshToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    Map<String, String> headers = {"Authorization": refreshToken};

    Uri uri = Uri.https(
      ApiEndPoints.baseUrl,
      ApiEndPoints.getRefreshSession,
      {ApiEndPoints.school: school}
          .map((key, value) => MapEntry(key, value.toString())),
    );
    return await dioHandle
        .getUri(uri,
            options: Options(
              headers: headers,
              validateStatus: (_) => true,
            ))
        .then((response) {
      return response.parseUser();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', 'REFRESH SESSION ERROR');
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [getRefreshSession]');
      return ApiUserResponse.error('Timed out');
    });
  }

  /// [HttpGet]
  @override
  Future<ApiBookingResponse> getSchoolResources(
      String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    var uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getSchoolResources,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken
        }.map((key, value) => MapEntry(key, value.toString())));

    return await dioHandle
        .getUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseSchoolResources();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [getSchoolResources]');
      return ApiBookingResponse.error('Timed out');
    });
  }

  /// [HttpGet]
  @override
  Future<ApiBookingResponse> getResourceAvailabilities(String sessionToken,
      String defaultSchool, String resourceId, DateTime date) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getResourceAvailability + resourceId,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken,
          ApiEndPoints.date: date,
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .getUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseSchoolResource();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [getResourceAvailabilities]');
      return ApiBookingResponse.error('Timed out');
    });
  }

  /// [HttpGet]
  @override
  Future<ApiBookingResponse> getUserBookings(
      String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getUserBookings,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken,
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .getUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseUserBookings();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [getUserBookings]');
      return ApiBookingResponse.error('Timed out');
    });
  }

  /// [HttpPut]
  @override
  Future<ApiUserResponse> putRegisterUserEvent(
      String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.putRegisterEvent + eventId,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken
        }.map((key, value) => MapEntry(key, value.toString())));
    return dioHandle
        .putUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseRegisterOrUnregister();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [getUserBookings]');
      return ApiUserResponse.error('Timed out');
    });
  }

  /// [HttpPut]
  @override
  Future<ApiUserResponse> putUnregisterUserEvent(
      String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.getSchedules + eventId,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .putUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseRegisterOrUnregister();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [putUnregisterUserEvent]');
      return ApiUserResponse.error('Timed out');
    });
  }

  /// [HttpPut]
  @override
  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(
      String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.putRegisterAll,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .putUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseMultiRegistrationResult();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [putRegisterAllAvailableUserEvents]');
      return ApiUserResponse.error('Timed out');
    });
  }

  /// [HttpPut]
  @override
  Future<ApiBookingResponse> putBookResource(
      String sessionToken,
      String defaultSchool,
      String resourceId,
      DateTime date,
      AvailabilityValue bookingSlot) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {
      ApiEndPoints.resourceId: resourceId,
      ApiEndPoints.date: date.toIso8601String(),
      ApiEndPoints.bookingSlot: bookingSlot,
    };
    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.putBookResource,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .putUri(uri,
            data: jsonEncode(data),
            options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseBookResource();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [putBookResource]');
      return ApiBookingResponse.error('Timed out');
    });
  }

  /// [HttpPut]
  @override
  Future<ApiBookingResponse> putUnbookResource(
      String sessionToken, String defaultSchool, String bookingId) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.putUnbookResource,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken,
          ApiEndPoints.bookingId: bookingId
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .putUri(uri, options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseUnbookResource();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [putUnbookResource]');
      return ApiBookingResponse.error('Timed out');
    });
  }

  /// [HttpPut]
  @override
  Future<ApiBookingResponse> putConfirmBooking(String sessionToken,
      String defaultSchool, String resourceId, String bookingId) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {
      ApiEndPoints.resourceId: resourceId,
      ApiEndPoints.bookingId: bookingId,
    };

    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.putConfirmBooking,
        {
          ApiEndPoints.school: school.toString(),
          ApiEndPoints.sessionToken: sessionToken,
        }.map((key, value) => MapEntry(key, value.toString())));
    return await dioHandle
        .putUri(uri,
            data: jsonEncode(data),
            options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseConfirmBooking();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [putConfirmBooking]');
      return ApiBookingResponse.error('Timed out');
    });
  }

  /// [HttpPost]
  @override
  Future<ApiUserResponse> postUserLogin(
      String username, String password, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {
      ApiEndPoints.username: username,
      ApiEndPoints.password: password
    };
    Uri uri = Uri.https(
        ApiEndPoints.baseUrl,
        ApiEndPoints.postUserLogin,
        {ApiEndPoints.school: school}
            .map((key, value) => MapEntry(key, value.toString())));
    log(uri.toString());
    return await dioHandle
        .postUri(uri,
            data: jsonEncode(data),
            options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseUser();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [postUserLogin]');
      return ApiUserResponse.error('Timed out');
    });
  }

  /// [HttpPost]
  @override
  Future<ApiBugReportResponse> postSubmitIssue(
      String issueSubject, String issueBody) async {
    final Map<String, String> data = {
      ApiEndPoints.issueSubject: issueSubject,
      ApiEndPoints.issueBody: issueBody
    };
    Uri uri = Uri.https(
      ApiEndPoints.baseUrl,
      ApiEndPoints.postSubmitIssue,
    );
    return await dioHandle
        .postUri(uri,
            data: jsonEncode(data),
            options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseIssue();
    }).onError((error, stackTrace) {
      log(
          name: 'backend_repository',
          error: error,
          '$error.message in [postSubmitIssue]');
      return ApiBugReportResponse.error('Timed out');
    });
  }
}
