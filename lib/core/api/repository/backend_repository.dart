import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_endpoints.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/api/cert_bypass.dart';
import 'package:tumble/core/api/interface/ibackend_service.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/main_app_widget/data/schools.dart';

class BackendRepository implements IBackendService {
  /// [HttpGet]
  @override
  Future<ApiResponse> getSchedule(
      String scheduleId, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl,
          '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school.toString(),
      });
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return response.parseSchedule();
    } else {
      var uri = Uri.https(
          ApiEndPoints.baseUrl, '${ApiEndPoints.getOneSchedule}$scheduleId', {
        ApiEndPoints.school: school,
      });
      final response = await compute(http.get, uri);
      return response.parseSchedule();
    }
  }

  /// [HttpGet]
  @override
  Future<ApiResponse> getPrograms(
      String searchQuery, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(
          ApiEndPoints.debugBaseUrl, ApiEndPoints.getSchedules, {
        ApiEndPoints.search: searchQuery,
        ApiEndPoints.school: school.toString()
      });
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return await response.parsePrograms();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules, {
        ApiEndPoints.search: searchQuery,
        ApiEndPoints.school: school.toString()
      });
      final response = await compute(http.get, uri);
      return response.parsePrograms();
    }
    // final response = await compute(http.get, uri);
  }

  /// [HttpGet]
  @override
  Future getUserEvents(String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(
          ApiEndPoints.debugBaseUrl, ApiEndPoints.getUserEvents, {
        ApiEndPoints.sessionToken: sessionToken,
        ApiEndPoints.school: school.toString()
      });
      final response = await HttpService.sendGetRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }

      return await response.parseUserEvents();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules, {
        ApiEndPoints.sessionToken: sessionToken,
        ApiEndPoints.school: school.toString()
      });
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

      final response =
          await HttpService.sendGetRequestToServer(uri, headers: headers);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
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
  Future putRegisterUserEvent(
      String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.postUserLogin,
          {ApiEndPoints.school: school.toString()});

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return response.parseRegisterOrUnregister();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.school: school.toString()});
      final response = await http.put(uri);
      return response.parseRegisterOrUnregister();
    }
  }

  /// [HttpPut]
  @override
  Future putUnregisterUserEvent(
      String eventId, String sessionToken, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;

    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.postUserLogin,
          {ApiEndPoints.school: school.toString()});

      final response = await HttpService.sendPutRequestToServer(uri);
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return response.parseRegisterOrUnregister();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.school: school.toString()});
      final response = await http.put(uri);
      return response.parseRegisterOrUnregister();
    }
  }

  /// [HttpPost]
  @override
  Future postUserLogin(
      String username, String password, String defaultSchool) async {
    final school = Schools().fromString(defaultSchool).schoolId.index;
    log(school.toString());
    final Map<String, String> body = {
      ApiEndPoints.username: username,
      ApiEndPoints.password: password
    };
    if (kDebugMode) {
      var uri = Uri.https(ApiEndPoints.debugBaseUrl, ApiEndPoints.postUserLogin,
          {ApiEndPoints.school: school.toString()});

      final response =
          await HttpService.sendPostRequestToServer(uri, jsonEncode(body));
      if (response == null) {
        return ApiResponse.error(FetchResponse.timeoutError);
      }
      return await response.parseUser();
    } else {
      var uri = Uri.https(ApiEndPoints.baseUrl, ApiEndPoints.getSchedules,
          {ApiEndPoints.school: school.toString()});
      final response = await http.post(uri, body: body);
      return response.parseUser();
    }
  }
}
