import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/multi_registration_result_model.dart';
import 'package:tumble/core/models/backend_models/user_event_collection_model.dart';

extension UserResponseParsing on Response {
  ApiResponse parseUser() {
    if (statusCode == 200) {
      return ApiResponse.authorized(kronoxUserModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.loginError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseUserEvents() {
    if (statusCode == 200) {
      return ApiResponse.completed(
          userEventCollectionModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseMultiRegistrationResult() {
    if (statusCode == 200) {
      return ApiResponse.completed(
          multiRegistrationResultModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }
}
