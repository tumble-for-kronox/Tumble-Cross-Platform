import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_endpoints.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/cert_bypass.dart';
import 'package:tumble/core/api/interface/ibackend_service.dart';
import 'package:tumble/core/extensions/api_response_extensions.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/upcoming_user_event_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';

import '../../models/api_models/available_user_event_model.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiResponse> getSchedule(String scheduleId, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school.toString(),
      });
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
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
  Future<ApiResponse> getPrograms(String searchQuery, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.search: searchQuery, ApiEndPoints.school: school.toString()});
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parsePrograms();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.search: searchQuery, ApiEndPoints.school: school.toString()});
      final response = await compute(http.get, uri);
      return response.parsePrograms();
    }
    // final response = await compute(http.get, uri);
  }

  /// [HttpGet]
  @override
  Future getUserEvents(String sessionToken, String defaultSchool) async {
    // List<AvailableUserEventModel> only_registered_events = [
    //   AvailableUserEventModel(
    //     id: "id",
    //     title: "Registered Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 28),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: true,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   ),
    //   AvailableUserEventModel(
    //     id: "id",
    //     title: "Registered Exam 2",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 28),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: true,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   ),
    // ];
    // List<AvailableUserEventModel> onlyPassedEvents = [
    //   AvailableUserEventModel(
    //     id: "",
    //     title: "Passed Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 10),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: true,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   ),
    //   AvailableUserEventModel(
    //     id: "",
    //     title: "Passed Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 10),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: true,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   )
    // ];
    // List<AvailableUserEventModel> mixedPassedRegisteredEvents = [
    //   AvailableUserEventModel(
    //     id: "id",
    //     title: "Passed Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 10),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: true,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   ),
    //   AvailableUserEventModel(
    //     id: "id",
    //     title: "Registered Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 28),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: true,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   )
    // ];
    // List<AvailableUserEventModel> onlyUnregisteredEvents = [
    //   AvailableUserEventModel(
    //     id: "id",
    //     title: "Unregistered Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 28),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: false,
    //     supportAvailable: false,
    //     requiresChoosingLocation: false,
    //   ),
    //   AvailableUserEventModel(
    //     id: "id",
    //     title: "Unregistered Exam 2",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     lastSignupDate: DateTime(2022, 8, 28),
    //     participatorId: null,
    //     supportId: null,
    //     anonymousCode: "",
    //     isRegistered: false,
    //     supportAvailable: true,
    //     requiresChoosingLocation: true,
    //   )
    // ];
    // List<UpcomingUserEventModel> upcomingEvents = [
    //   UpcomingUserEventModel(
    //     title: "Upcoming Exam 1",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     firstSignupDate: DateTime(2022, 8, 28),
    //   ),
    //   UpcomingUserEventModel(
    //     title: "Upcoming Exam 2",
    //     type: "exam",
    //     eventStart: DateTime(2022, 8, 30, 12),
    //     eventEnd: DateTime(2022, 8, 30, 16),
    //     firstSignupDate: DateTime(2022, 8, 28),
    //   )
    // ];

    // return ApiResponse.completed(UserEventCollectionModel(
    //   upcomingEvents: upcomingEvents,
    //   registeredEvents: mixedPassedRegisteredEvents,
    //   unregisteredEvents: onlyUnregisteredEvents,
    // ));

    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.getUserEvents,
          {ApiEndPoints.sessionToken: sessionToken, ApiEndPoints.school: school.toString()});
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
      }

      return await response.parseUserEvents();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.sessionToken: sessionToken, ApiEndPoints.school: school.toString()});
      final response = await compute(http.get, uri);
      return response.parseUserEvents();
    }
  }

  /// [HttpGet]
  @override
  Future getRefreshSession(String refreshToken, String defaultSchool) async {
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
        return ApiResponse.error(RuntimeErrorType.timeoutError());
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

  /// [HttpPut]
  @override
  Future putRegisterUserEvent(String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putRegisterEvent + eventId,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
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
  Future putUnregisterUserEvent(String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putUnregisterEvent + eventId,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
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
  Future putRegisterAllAvailableUserEvents(String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.putRegisterAll,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});
      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
      }
      return response.parseMultiRegistrationResult();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.putRegisterAll,
          {ApiEndPoints.school: school.toString(), ApiEndPoints.sessionToken: sessionToken});
      final response = await http.put(uri);
      return response.parseMultiRegistrationResult();
    }
  }

  /// [HttpPost]
  @override
  Future postUserLogin(String username, String password, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    final Map<String, String> body = {ApiEndPoints.username: username, ApiEndPoints.password: password};
    if (kDebugMode) {
      var uri =
          Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.postUserLogin, {ApiEndPoints.school: school.toString()});

      final response = await HttpService.sendPostRequestToServer(uri, jsonEncode(body));
      if (response == null) {
        return ApiResponse.error(RuntimeErrorType.timeoutError());
      }
      return await response.parseUser();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules, {ApiEndPoints.school: school.toString()});
      final response = await http.post(uri, body: body);
      return response.parseUser();
    }
  }
}
