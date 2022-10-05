import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../api/apiservices/api_user_response.dart';
import '../../api/apiservices/runtime_error_type.dart';
import '../../models/api_models/kronox_user_model.dart';
import '../../models/api_models/multi_registration_result_model.dart';
import '../../models/api_models/user_event_collection_model.dart';

extension UserResponseParsing on Response {
  ApiUserResponse parseUser() {
    if (statusCode == 200) {
      return ApiUserResponse.authorized(kronoxUserModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiUserResponse.error(RuntimeErrorType.loginError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }

  ApiUserResponse parseUserEvents() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(userEventCollectionModelFromJson(body));
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

  ApiUserResponse parseMultiRegistrationResult() {
    if (statusCode == 200) {
      return ApiUserResponse.completed(multiRegistrationResultModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiUserResponse.unauthorized(RuntimeErrorType.authenticationError());
    }
    return ApiUserResponse.error(RuntimeErrorType.unknownError());
  }
}

extension UserHttpClientResponseParsing on HttpClientResponse {
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
