import 'package:http/http.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/apiservices/fetch_response.dart';
import 'package:tumble/models/api_models/program_model.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import "package:collection/collection.dart";
import 'package:tumble/models/ui_models/week_model.dart';

extension ResponseParsing on Response {
  dynamic parseSchedule() {
    if (statusCode == 200) {
      return ApiResponse.completed(scheduleModelFromJson(body));
    }
    return ApiResponse.error(FetchResponse.error);
  }

  dynamic parseProgram() {
    if (statusCode == 200) {
      return ApiResponse.completed(programModelFromJson(body));
    }
    return ApiResponse.error(FetchResponse.error);
  }
}

extension ScheduleParsing on ScheduleModel {
  List<Week> splitToWeek() {
    return groupBy(days, (Day day) => day.weekNumber)
        .entries
        .map((weekNumberToDayList) => Week(
            weekNumber: weekNumberToDayList.key,
            days: weekNumberToDayList.value))
        .toList();
  }
}
