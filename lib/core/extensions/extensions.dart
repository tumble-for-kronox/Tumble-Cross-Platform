import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import "package:collection/collection.dart";
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/helpers/color_picker.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/program_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/models/ui_models/course_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';

extension ResponseParsing on Response {
  ApiResponse parseSchedule() {
    if (statusCode == 200) {
      return ApiResponse.completed(scheduleModelFromJson(body));
    }
    return ApiResponse.error(FetchResponse.scheduleFetchError);
  }

  ApiResponse parsePrograms() {
    if (statusCode == 200) {
      return ApiResponse.completed(programModelFromJson(body));
    }
    return ApiResponse.error(FetchResponse.programFetchEerror);
  }

  ApiResponse parseUser() {
    if (statusCode == 200) {
      return ApiResponse.completed(kronoxUserModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.loginError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  ApiResponse parseUserEvents() {
    if (statusCode == 200) {
      return ApiResponse.completed(userEventCollectionModelFromJson(body));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }
}

extension HttpClientResponseParsing on HttpClientResponse {
  Future<ApiResponse> parsePrograms() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          programModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(FetchResponse.programFetchEerror);
  }

  Future<ApiResponse> parseSchedule() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          scheduleModelFromJson(await transform(utf8.decoder).join()));
    }
    return ApiResponse.error(FetchResponse.scheduleFetchError);
  }

  Future<ApiResponse> parseUser() async {
    if (statusCode == 200) {
      return ApiResponse.completed(
          kronoxUserModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiResponse.error(FetchResponse.loginError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  Future<ApiResponse> parseUserEvents() async {
    if (statusCode == 200) {
      return ApiResponse.completed(userEventCollectionModelFromJson(
          await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
  }

  ApiResponse parseRegisterOrUnregister() {
    if (statusCode == 200) {
      return ApiResponse.completed(true);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(FetchResponse.authenticationError);
    }
    return ApiResponse.error(FetchResponse.unknownError);
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

  List<CourseUiModel?> findNewCourses() {
    List<String> seen = [];
    List<CourseUiModel?> courseUiModels =
        (days.expand((element) => element.events).toList())
            .map((event) {
              final courseId = event.course.id;
              if (!seen.contains(courseId)) {
                seen.add(courseId);
                return CourseUiModel(
                    scheduleId: id,
                    courseId: courseId,
                    color: ColorPicker().getRandomHexColor());
              }
            })
            .whereType<CourseUiModel>()
            .toList();
    log(courseUiModels.toString());
    return courseUiModels;
  }
}

extension StringParse on String {
  String capitalize() => this[0].toUpperCase() + substring(1).toLowerCase();

  String humanize() {
    List<String> stringFragments = split('_');
    for (int i = 0; i < stringFragments.length; i++) {
      stringFragments[i] = stringFragments[i].capitalize();
    }
    return stringFragments.join(' ');
  }
}

extension GetSchoolFromString on Schools {
  School fromString(String s) =>
      Schools.schools.where((school) => school.schoolName == s).single;
}
