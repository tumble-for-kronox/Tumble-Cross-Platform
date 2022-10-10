import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/multi_registration_result_model.dart';
import 'package:tumble/core/models/backend_models/user_event_collection_model.dart';

extension UserResponseParsing on Response {
  UserResponse parseUser() {
    if (statusCode == 200) {
      return UserResponse.authorized(kronoxUserModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return UserResponse.error(RuntimeErrorType.loginError());
    }
    return UserResponse.error(RuntimeErrorType.unknownError());
  }

  UserResponse parseUserEvents() {
    if (statusCode == 200) {
      return UserResponse.completed(userEventCollectionModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return UserResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return UserResponse.error(RuntimeErrorType.unknownError());
  }

  UserResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return UserResponse.completed(true);
    } else if (statusCode == 401) {
      return UserResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return UserResponse.error(RuntimeErrorType.unknownError());
  }

  UserResponse parseMultiRegistrationResult() {
    if (statusCode == 200) {
      return UserResponse.completed(multiRegistrationResultModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return UserResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return UserResponse.error(RuntimeErrorType.unknownError());
  }
}

/* extension UserHttpClientResponseParsing on HttpClientResponse {
  Future<ApiUserResponse> parseUser() async {
    if (statusCode == 200) {
      return ApiUserResponse.authorized(kronoxUserModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiUserResponse.error(RuntimeErrorType.loginError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiUserResponse> parseUserEvents() async {
    if (statusCode == 200) {
      return ApiUserResponse.completed(userEventCollectionModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  ApiUserResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiUserResponse> parseMultiRegistrationResult() async {
    if (statusCode == 200) {
      return ApiUserResponse.completed(multiRegistrationResultModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiUserResponse.error(RuntimeErrorType.programFetchError());
  }
}
 */