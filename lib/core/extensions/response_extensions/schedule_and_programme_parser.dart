import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/models/backend_models/program_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

extension ScheduleOrProgrammeResponseParsing on Response {
  ScheduleOrProgrammeResponse parseSchedule() {
    if (statusCode == 200) {
      return ScheduleOrProgrammeResponse.fetched(scheduleModelFromJson(jsonEncode(data)));
    }
    return ScheduleOrProgrammeResponse.error(RuntimeErrorType.scheduleFetchError(), S.popUps.timeOutDecsription());
  }

  ScheduleOrProgrammeResponse parsePrograms() {
    if (statusCode == 200) {
      return ScheduleOrProgrammeResponse.fetched(programModelFromJson(jsonEncode(data)));
    }
    return ScheduleOrProgrammeResponse.error(RuntimeErrorType.programFetchError(), S.popUps.timeOutDecsription());
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
