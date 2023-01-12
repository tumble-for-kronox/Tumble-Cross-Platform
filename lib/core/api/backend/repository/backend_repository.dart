import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/auth_interceptor.dart';
import 'package:tumble/core/api/backend/data/constants.dart';
import 'package:tumble/core/api/backend/data/endpoint_uri.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/data/endpoints.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/extensions/response_extensions/booking_parser.dart';
import 'package:tumble/core/extensions/response_extensions/misc_parser.dart';
import 'package:tumble/core/extensions/response_extensions/schedule_and_programme_parser.dart';
import 'package:tumble/core/extensions/response_extensions/user_parser.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

/// The BackendRepository class is an implementation of the
/// IBackendService interface and it handles making HTTP requests
/// to Tumbles backend server. It uses the Dio library for making the
/// requests and handling responses.
class BackendRepository extends AuthInterceptor {
  final _dioHandle = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: Constants.connectionTimeout,
    receiveTimeout: Constants.receiveTimeout,
  ));
  final _schools = Schools();

  /// [HttpGet]
  /// This function makes a GET request to the server to retrieve
  /// schedule details for a given schedule ID and default school.
  /// The function takes the schedule ID and the default school as
  /// input parameters, it converts the default school to the school's
  /// index using the _schools object, creates a URI using the endpoint
  /// for getting one schedule and the scheduleId, and the school index,
  /// it then makes a GET request to that URI and returns the response
  /// after parsing it using the parseSchedule method.

  Future<ApiResponse> getSchedule(
      String scheduleId, String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .getUri(EndpointUri.getSchedule(scheduleId, schoolIndex))
        .then((response) => response.parseSchedule())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpGet]
  /// makes a GET request to the server to retrieve program details for
  /// a given search query and default school. The function takes the
  /// search query and the default school as input parameters, it converts
  /// the default school to the school's index using the _schools object,
  /// creates a URI using the endpoint for getting schedules, the search
  /// query and the school index, it then makes a GET request to that URI and
  /// returns the response after parsing it using the parsePrograms method.

  Future<ApiResponse> getPrograms(
      String searchQuery, String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .getUri(EndpointUri.getProgram(searchQuery, defaultSchool, schoolIndex))
        .then((response) => response.parsePrograms())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpGet]
  /// This function retrieves a user's events from the backend API.
  /// It makes a GET request to the endpoint specified in
  /// Endpoints.getUserEvents, passing along the session token and the
  /// school ID as query parameters. The school ID is obtained by calling
  /// _schools.fromString(defaultSchool).schoolId.index. The response is
  /// parsed into a UserResponse object using the parseUserEvents extension
  /// method. If an error occurs during the request, a log is written with
  /// the error message and a UserResponse.error object is returned with a
  /// RuntimeErrorType.timeoutError.

  Future<ApiResponse> getUserEvents(String defaultSchool) async {
    final schoolId = _schools.fromString(defaultSchool).schoolId;

    return await _dioHandle
        .getUri(EndpointUri.getUserEvents(schoolId))
        .then((response) => response.parseUserEvents())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpGet]
  /// The method takes in a sessionToken and defaultSchool as parameters
  /// and returns a Future<BookingResponse>. The defaultSchool parameter
  /// is used to identify the school for which resources are being requested,
  /// while the sessionToken is used for user identification and authentication.
  /// The method uses the Dio package to make the HTTP request and maps
  /// the response to a BookingResponse object. In case of an error, the
  /// method logs the error message and returns a BookingResponse.error
  /// object with a RuntimeErrorType.timeoutError().

  Future<ApiResponse> getSchoolResources(String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .getUri(EndpointUri.getSchoolResources(schoolIndex))
        .then((response) => response.parseSchoolResources())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpGet]

  Future<ApiResponse> getResourceAvailabilities(
      String defaultSchool, String resourceId, DateTime date) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;
    return await _dioHandle
        .getUri(EndpointUri.getResourceAvailabilities(
            resourceId, schoolIndex, date))
        .then((response) => response.parseSchoolResource())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpGet]

  Future<ApiResponse> getUserBookings(String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .getUri(EndpointUri.getUserBookings(schoolIndex))
        .then((response) {
      return response.parseUserBookings();
    }).onError((error, stackTrace) => ApiResponse.error(
            RuntimeErrorType.timeoutError(), S.popUps.timeOutDecsription()));
  }

  /// [HttpPut]

  Future<ApiResponse> putRegisterUserEvent(
      String eventId, String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .putUri(EndpointUri.putRegisterUserEvent(eventId, schoolIndex))
        .then((response) => response.parseRegisterOrUnregister())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPut]

  Future<ApiResponse> putUnregisterUserEvent(
      String eventId, String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .putUri(EndpointUri.putUnregisterUserEvent(eventId, schoolIndex))
        .then((response) => response.parseRegisterOrUnregister())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPut]

  Future<ApiResponse> putRegisterAll(String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .putUri(EndpointUri.putRegisterAll(schoolIndex))
        .then((response) => response.parseMultiRegistrationResult())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPut]

  Future<ApiResponse> putBookResource(String defaultSchool, String resourceId,
      DateTime date, AvailabilityValue bookingSlot) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {
      Endpoints.resourceId: resourceId,
      Endpoints.date: date.toIso8601String(),
      Endpoints.bookingSlot: bookingSlot,
    };
    return await _dioHandle
        .putUri(EndpointUri.putBookResource(schoolIndex),
            data: jsonEncode(data))
        .then((response) => response.parseBookResource())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPut]

  Future<ApiResponse> putUnbookResource(
      String defaultSchool, String bookingId) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;

    return await _dioHandle
        .putUri(EndpointUri.putUnbookResource(schoolIndex, bookingId))
        .then((response) => response.parseUnbookResource())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPut]

  Future<ApiResponse> putConfirmBooking(
      String defaultSchool, String resourceId, String bookingId) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {
      Endpoints.resourceId: resourceId,
      Endpoints.bookingId: bookingId,
    };
    return await _dioHandle
        .putUri(EndpointUri.putConfirmBooking(schoolIndex),
            data: jsonEncode(data))
        .then((response) => response.parseConfirmBooking())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPost]

  Future<ApiResponse> postUserLogin(
      String username, String password, String defaultSchool) async {
    final schoolIndex = _schools.fromString(defaultSchool).schoolId.index;
    final Map<String, dynamic> data = {
      Endpoints.username: username,
      Endpoints.password: password
    };
    return await _dioHandle
        .postUri(EndpointUri.postUserLogin(schoolIndex), data: jsonEncode(data))
        .then((response) => response.parseUser())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpPost]

  Future<ApiResponse> postSubmitIssue(
      String issueSubject, String issueBody) async {
    final Map<String, String> data = {
      Endpoints.issueSubject: issueSubject,
      Endpoints.issueBody: issueBody
    };
    return await _dioHandle
        .postUri(EndpointUri.postSubmitIssue(), data: jsonEncode(data))
        .then((response) => response.parseIssue())
        .onError((error, stackTrace) => _error());
  }

  /// [HttpGet]
  Future<ApiResponse> getUser() async => await _dioHandle
      .getUri(EndpointUri.getUser())
      .then((response) => response.parseUser())
      .onError((error, stackTrace) => _error());

  ApiResponse _error() => ApiResponse.error(
      RuntimeErrorType.timeoutError(), S.popUps.timeOutDecsription());
}
