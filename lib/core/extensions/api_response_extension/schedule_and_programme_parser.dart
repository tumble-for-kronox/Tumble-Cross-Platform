import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

import '../../api/apiservices/api_schedule_or_programme_response.dart';
import '../../api/apiservices/runtime_error_type.dart';
import '../../models/api_models/program_model.dart';
import '../../models/api_models/schedule_model.dart';

extension ScheduleOrProgrammeResponseParsing on Response {
  ApiScheduleOrProgrammeResponse parseSchedule() {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.fetched(
          scheduleModelFromJson(jsonEncode(data)));
    }
    return ApiScheduleOrProgrammeResponse.error(
        RuntimeErrorType.scheduleFetchError());
  }

  ApiScheduleOrProgrammeResponse parsePrograms() {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.fetched(
          programModelFromJson(jsonEncode(data)));
    }
    return ApiScheduleOrProgrammeResponse.error(
        RuntimeErrorType.programFetchError());
  }
}

/* extension ScheduleOrProgrammeHttpClientResponseParsing on HttpClientResponse {
  Future<ApiScheduleOrProgrammeResponse> parsePrograms() async {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.fetched(programModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiScheduleOrProgrammeResponse.error(RuntimeErrorType.programFetchError());
  }

  Future<ApiScheduleOrProgrammeResponse> parseSchedule() async {
    if (statusCode == 200) {
      return ApiScheduleOrProgrammeResponse.fetched(scheduleModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiScheduleOrProgrammeResponse.error(RuntimeErrorType.scheduleFetchError());
  }
} */
