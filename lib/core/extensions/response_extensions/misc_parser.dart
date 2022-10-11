import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/bug_report_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';

extension ResponseParsing on Response {
  Future<BugReportResponse> parseIssue() async {
    if (statusCode == 200) {
      return BugReportResponse.success('Success');
    }
    return BugReportResponse.error(RuntimeErrorType.unknownError());
  }
}
/* 
extension HttpClientResponseParsing on HttpClientResponse {
  Future<ApiBugReportResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiBugReportResponse.success('Success');
    }
    return ApiBugReportResponse.error(RuntimeErrorType.unknownError());
  }
} */
