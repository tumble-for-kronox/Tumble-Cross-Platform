import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/data/constants.dart';
import 'package:tumble/core/api/backend/interceptors/auth_interceptor.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/bug_report_response.dart';
import 'package:tumble/core/api/backend/data/endpoints.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/interface/ibackend_service.dart';
import 'package:tumble/core/extensions/response_extensions/booking_parser.dart';
import 'package:tumble/core/extensions/response_extensions/misc_parser.dart';
import 'package:tumble/core/extensions/response_extensions/schedule_and_programme_parser.dart';
import 'package:tumble/core/extensions/response_extensions/user_parser.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class BackendRepository implements IBackendService {
  final _dioHandle = Dio(BaseOptions(
    connectTimeout: Constants.connectionTimeout,
    receiveTimeout: Constants.receiveTimeout,
  ))
    ..interceptors.add(AuthInterceptor());
  final _schools = Schools();

  /// [HttpGet]
  @override
  Future<ScheduleOrProgrammeResponse> getSchedule(String scheduleId, String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        Endpoints.baseUrl,
        '${Endpoints.getOneSchedule}$scheduleId',
        {
          Endpoints.school: school.toString(),
        }.map((key, value) => MapEntry(key, value.toString())));

    return await _dioHandle.getUri(uri, options: Options(validateStatus: (context) => true)).then((response) {
      return response.parseSchedule();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getRequestSchedule]');
      return ScheduleOrProgrammeResponse.error(RuntimeErrorType.timeoutError(), S.popUps.timeOutDecsription());
    });
  }

  /// [HttpGet]
  @override
  Future<ScheduleOrProgrammeResponse> getPrograms(String searchQuery, String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        Endpoints.baseUrl,
        Endpoints.getSchedules,
        {Endpoints.search: searchQuery, Endpoints.school: school.toString()}
            .map((key, value) => MapEntry(key, value.toString())));

    return await _dioHandle.getUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parsePrograms();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getPrograms]');
      return ScheduleOrProgrammeResponse.error(RuntimeErrorType.timeoutError(), S.popUps.timeOutDecsription());
    });
  }

  /// [HttpGet]
  @override
  Future<UserResponse> getUserEvents(String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(Endpoints.baseUrl, Endpoints.getUserEvents,
        {Endpoints.school: school.toString()}.map((key, value) => MapEntry(key, value.toString())));

    return await _dioHandle.getUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseUserEvents();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getUserEvents]');
      return UserResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpGet]
  @override
  Future<UserResponse> getRefreshSession(String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
      Endpoints.baseUrl,
      Endpoints.getRefreshSession,
      {Endpoints.school: school}.map((key, value) => MapEntry(key, value.toString())),
    );
    return await _dioHandle
        .getUri(uri,
            options: Options(
              validateStatus: (_) => true,
            ))
        .then((response) {
      return response.parseUser();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', 'REFRESH SESSION ERROR');
      log(name: 'backend_repository', error: error, '$error.message in [getRefreshSession]');
      return UserResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpGet]
  @override
  Future<BookingResponse> getSchoolResources(String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    var uri = Uri.https(Endpoints.baseUrl, Endpoints.getSchoolResources,
        {Endpoints.school: school.toString()}.map((key, value) => MapEntry(key, value.toString())));

    return await _dioHandle.getUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseSchoolResources();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getSchoolResources]');
      return BookingResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpGet]
  @override
  Future<BookingResponse> getResourceAvailabilities(String defaultSchool, String resourceId, DateTime date) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        Endpoints.baseUrl,
        Endpoints.getResourceAvailability + resourceId,
        {
          Endpoints.school: school.toString(),
          Endpoints.date: date,
        }.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle.getUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseSchoolResource();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getResourceAvailabilities]');
      return BookingResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpGet]
  @override
  Future<BookingResponse> getUserBookings(String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        Endpoints.baseUrl,
        Endpoints.getUserBookings,
        {
          Endpoints.school: school.toString(),
        }.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle.getUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseUserBookings();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getUserBookings]');
      return BookingResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPut]
  @override
  Future<UserResponse> putRegisterUserEvent(String eventId, String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(Endpoints.baseUrl, Endpoints.putRegisterEvent + eventId,
        {Endpoints.school: school.toString()}.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle.putUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseRegisterOrUnregister();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [getUserBookings]');
      return UserResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPut]
  @override
  Future<UserResponse> putUnregisterUserEvent(String eventId, String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(Endpoints.baseUrl, Endpoints.putUnregisterEvent + eventId,
        {Endpoints.school: school.toString()}.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle.putUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseRegisterOrUnregister();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [putUnregisterUserEvent]');
      return UserResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPut]
  @override
  Future<UserResponse> putRegisterAllAvailableUserEvents(String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(Endpoints.baseUrl, Endpoints.putRegisterAll,
        {Endpoints.school: school.toString()}.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle.putUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseMultiRegistrationResult();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [putRegisterAllAvailableUserEvents]');
      return UserResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPut]
  @override
  Future<BookingResponse> putBookResource(
      String defaultSchool, String resourceId, DateTime date, AvailabilityValue bookingSlot) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    final Map<String, dynamic> data = {
      Endpoints.resourceId: resourceId,
      Endpoints.date: date.toIso8601String(),
      Endpoints.bookingSlot: bookingSlot,
    };
    Uri uri = Uri.https(Endpoints.baseUrl, Endpoints.putBookResource,
        {Endpoints.school: school.toString()}.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle
        .putUri(uri, data: jsonEncode(data), options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseBookResource();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [putBookResource]');
      return BookingResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPut]
  @override
  Future<BookingResponse> putUnbookResource(String defaultSchool, String bookingId) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    Uri uri = Uri.https(
        Endpoints.baseUrl,
        Endpoints.putUnbookResource,
        {Endpoints.school: school.toString(), Endpoints.bookingId: bookingId}
            .map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle.putUri(uri, options: Options(validateStatus: (_) => true)).then((response) {
      return response.parseUnbookResource();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [putUnbookResource]');
      return BookingResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPut]
  @override
  Future<BookingResponse> putConfirmBooking(String defaultSchool, String resourceId, String bookingId) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;

    final Map<String, dynamic> data = {
      Endpoints.resourceId: resourceId,
      Endpoints.bookingId: bookingId,
    };

    Uri uri = Uri.https(
        Endpoints.baseUrl,
        Endpoints.putConfirmBooking,
        {
          Endpoints.school: school.toString(),
        }.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle
        .putUri(uri, data: jsonEncode(data), options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseConfirmBooking();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [putConfirmBooking]');
      return BookingResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPost]
  @override
  Future<UserResponse> postUserLogin(String username, String password, String defaultSchool) async {
    final school = _schools.fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {Endpoints.username: username, Endpoints.password: password};
    Uri uri = Uri.https(Endpoints.baseUrl, Endpoints.postUserLogin,
        {Endpoints.school: school}.map((key, value) => MapEntry(key, value.toString())));
    return await _dioHandle
        .postUri(uri, data: jsonEncode(data), options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseUser();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [postUserLogin]');
      return UserResponse.error(RuntimeErrorType.timeoutError());
    });
  }

  /// [HttpPost]
  @override
  Future<BugReportResponse> postSubmitIssue(String issueSubject, String issueBody) async {
    final Map<String, String> data = {Endpoints.issueSubject: issueSubject, Endpoints.issueBody: issueBody};
    Uri uri = Uri.https(
      Endpoints.baseUrl,
      Endpoints.postSubmitIssue,
    );
    return await _dioHandle
        .postUri(uri, data: jsonEncode(data), options: Options(validateStatus: (_) => true))
        .then((response) {
      return response.parseIssue();
    }).onError((error, stackTrace) {
      log(name: 'backend_repository', error: error, '$error.message in [postSubmitIssue]');
      return BugReportResponse.error(RuntimeErrorType.timeoutError());
    });
  }
}
