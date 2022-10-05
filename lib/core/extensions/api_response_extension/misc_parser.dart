import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:tumble/core/api/apiservices/api_booking_response.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';

import '../../api/apiservices/runtime_error_type.dart';

extension ResponseParsing on Response {
  Future<ApiBugReportResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiBugReportResponse.success('Success');
    }
    return ApiBugReportResponse.error(RuntimeErrorType.unknownError());
  }
}

extension HttpClientResponseParsing on HttpClientResponse {
  Future<ApiBugReportResponse> parseIssue() async {
    if (statusCode == 200) {
      return ApiBugReportResponse.success('Success');
    }
    return ApiBugReportResponse.error(RuntimeErrorType.unknownError());
  }
}
