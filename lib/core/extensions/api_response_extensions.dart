import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';

import '../api/apiservices/api_response.dart';
import '../api/apiservices/runtime_error_type.dart';
import '../models/api_models/kronox_user_model.dart';
import '../models/api_models/multi_registration_result_model.dart';
import '../models/api_models/program_model.dart';
import '../models/api_models/schedule_model.dart';
import '../models/api_models/user_event_collection_model.dart';

extension ResponseParsing on Response {
  ApiResponse parseSchedule() {
    if (statusCode == 200) {
      return ApiResponse.completed(scheduleModelFromJson(body));
    }
    return ApiResponse.error(RuntimeErrorType.scheduleFetchError());
  }

  ApiResponse parsePrograms() {
    if (statusCode == 200) {
      return ApiResponse.completed(programModelFromJson(body));
    }
    return ApiResponse.error(RuntimeErrorType.programFetchError());
  }

  ApiResponse parseUser() {
    if (statusCode == 200) {
      return ApiResponse.completed(kronoxUserModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.error(RuntimeErrorType.loginError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiResponse.completed('Success');
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  ApiResponse parseUserEvents() {
    if (statusCode == 200) {
      return ApiResponse.completed(userEventCollectionModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  ApiResponse parseMultiRegistrationResult() {
    if (statusCode == 200) {
      return ApiResponse.completed(multiRegistrationResultModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }
}

extension HttpClientResponseParsing on HttpClientResponse {
  Future<ApiResponse> parsePrograms() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          programModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(RuntimeErrorType.programFetchError());
  }

  Future<ApiResponse> parseIssue() async {
    log(statusCode.toString());
    if (statusCode == 200) {
      return ApiResponse.completed('Success');
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiResponse> parseSchedule() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          scheduleModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(RuntimeErrorType.scheduleFetchError());
  }

  Future<ApiResponse> parseUser() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          kronoxUserModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiResponse.error(RuntimeErrorType.loginError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiResponse> parseUserEvents() async {
    if (statusCode == 200) {
      return ApiResponse.completed(userEventCollectionModelFromJson(
          await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiResponse> parseMultiRegistrationResult() async {
    if (statusCode == 200) {
      return ApiResponse.completed(multiRegistrationResultModelFromJson(
          await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(RuntimeErrorType.programFetchError());
  }
}
