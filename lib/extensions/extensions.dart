import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/apiservices/fetch_response.dart';
import 'package:tumble/models/api_models/kronox_user_model.dart';
import 'package:tumble/models/api_models/program_model.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import "package:collection/collection.dart";
import 'package:tumble/models/api_models/user_event_collection_model.dart';
import 'package:tumble/models/ui_models/week_model.dart';

extension ResponseParsing on Response {
  ApiResponse parseSchedule() {
    if (statusCode == 200) {
      return ApiResponse.completed(scheduleModelFromJson(body));
    }
    return ApiResponse.error(FetchResponse.fetchEerror);
  }

  ApiResponse parsePrograms() {
    if (statusCode == 200) {
      return ApiResponse.completed(programModelFromJson(body));
    }
    return ApiResponse.error(FetchResponse.fetchEerror);
  }

  ApiResponse parseUser() {
    if (statusCode == 200) {
      return ApiResponse.completed(kronoxUserModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.loginError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  ApiResponse parseUserEvents() {
    if (statusCode == 200) {
      return ApiResponse.completed(userEventCollectionModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }
}

extension HttpClientResponseParsing on HttpClientResponse {
  Future<ApiResponse> parsePrograms() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          programModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(FetchResponse.fetchEerror);
  }

  Future<ApiResponse> parseSchedule() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          scheduleModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(FetchResponse.fetchEerror);
  }

  Future<ApiResponse> parseUser() async {
    log("Login status: $statusCode");
    if (statusCode == 200) {
      return ApiResponse.completed(kronoxUserModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.loginError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  Future<ApiResponse> parseUserEvents() async {
    if (statusCode == 200) {
      return ApiResponse.completed(userEventCollectionModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }
}

extension ScheduleParsing on ScheduleModel {
  List<Week> splitToWeek() {
    return groupBy(days, (Day day) => day.weekNumber)
        .entries
        .map((weekNumberToDayList) => Week(
            weekNumber: weekNumberToDayList.key,
            days: weekNumberToDayList.value))
        .toList();
  }
}

extension StringParse on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
