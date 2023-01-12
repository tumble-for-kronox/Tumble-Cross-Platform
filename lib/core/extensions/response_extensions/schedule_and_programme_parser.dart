import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/models/backend_models/program_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

extension ScheduleOrProgrammeResponseParsing on Response {
  ApiResponse parseSchedule() {
    if (statusCode == 200) {
      return ApiResponse.fetched(scheduleModelFromJson(jsonEncode(data)));
    }
    return ApiResponse.error(RuntimeErrorType.scheduleFetchError(),
        S.popUps.scheduleHelpFirstLine());
  }

  ApiResponse parsePrograms() {
    if (statusCode == 200) {
      return ApiResponse.fetched(programModelFromJson(jsonEncode(data)));
    }
    return ApiResponse.error(RuntimeErrorType.programFetchError(),
        S.popUps.missingProgramRequestDescription());
  }
}
