import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';

extension ResponseParsing on Response {
  Future<ApiResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiResponse.success('Success');
    }
    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }
}
