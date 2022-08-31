import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';

import '../api/apiservices/api_schedule_or_programme_response.dart';
import '../api/apiservices/runtime_error_type.dart';
import '../models/api_models/kronox_user_model.dart';
import '../models/api_models/multi_registration_result_model.dart';
import '../models/api_models/program_model.dart';
import '../models/api_models/schedule_model.dart';
import '../models/api_models/user_event_collection_model.dart';

extension ResponseParsing on Response {
  ApiScheduleOrProgrammeResponse parseSchedule() {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.completed(
          scheduleModelFromJson(body));
    }
    return ApiScheduleOrProgrammeResponse.error(
        RuntimeErrorType.scheduleFetchError());
  }

  ApiScheduleOrProgrammeResponse parsePrograms() {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.completed(
          programModelFromJson(body));
    }
    return ApiScheduleOrProgrammeResponse.error(
        RuntimeErrorType.programFetchError());
  }

  ApiUserResponse parseUser() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(kronoxUserModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiUserResponse.error(RuntimeErrorType.loginError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiBugReportResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiBugReportResponse.completed('Success');
    }
    return ApiBugReportResponse.error(RuntimeErrorType.unknownError());
  }

  ApiUserResponse parseUserEvents() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(userEventCollectionModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(
          RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  ApiUserResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(
          RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  ApiUserResponse parseMultiRegistrationResult() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(
          multiRegistrationResultModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(
          RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }
}

extension HttpClientResponseParsing on HttpClientResponse {
  Future<ApiScheduleOrProgrammeResponse> parsePrograms() async {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.completed(
          programModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiScheduleOrProgrammeResponse.error(
        RuntimeErrorType.programFetchError());
  }

  Future<ApiScheduleOrProgrammeResponse> parseSchedule() async {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.completed(
          scheduleModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiScheduleOrProgrammeResponse.error(
        RuntimeErrorType.scheduleFetchError());
  }

  Future<ApiBugReportResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiBugReportResponse.completed('Success');
    }
    return ApiBugReportResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiUserResponse> parseUser() async {
    if (statusCode == 200) {
      return ApiUserResponse.completed(
          kronoxUserModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiUserResponse.error(RuntimeErrorType.loginError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiUserResponse> parseUserEvents() async {
    if (statusCode == 200) {
      return ApiUserResponse.completed(userEventCollectionModelFromJson(
          await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(
          RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  ApiUserResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(
          RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiUserResponse> parseMultiRegistrationResult() async {
    if (statusCode == 200) {
      return ApiUserResponse.completed(multiRegistrationResultModelFromJson(
          await transform(utf8.decoder).join()));
    }
    return ApiUserResponse.error(RuntimeErrorType.programFetchError());
  }
}
