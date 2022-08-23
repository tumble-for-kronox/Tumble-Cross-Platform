import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "package:collection/collection.dart";
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/helpers/color_picker.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/program_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';
import 'package:uuid/uuid.dart';

import '../database/repository/database_repository.dart';
import '../dependency_injection/get_it_instances.dart';

extension ScheduleParsing on ScheduleModel {
  List<Week> splitToWeek() {
    return groupBy(days, (Day day) => day.weekNumber)
        .entries
        .map((weekNumberToDayList) => Week(weekNumber: weekNumberToDayList.key, days: weekNumberToDayList.value))
        .toList();
  }

  Future<List<CourseUiModel?>> findNewCourses(String scheduleId) async {
    DatabaseRepository databaseService = getIt<DatabaseRepository>();

    List<String> seen = [];
    seen.addAll((await databaseService.getCachedCoursesFromId(scheduleId)).map((e) => e.courseId));
    List<CourseUiModel?> courseUiModels = (days.expand((element) => element.events).toList())
        .map((event) {
          final courseId = event.course.id;
          if (!seen.contains(courseId)) {
            seen.add(courseId);
            return CourseUiModel(scheduleId: id, courseId: courseId, color: ColorPicker().getRandomHexColor());
          }
        })
        .whereType<CourseUiModel>()
        .toList();
    return courseUiModels;
  }

  bool isNotPhonySchedule() {
    return days.any((element) => element.events.isNotEmpty);
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

  int encodeUniqueIdentifier() {
    List<int> byteArray = utf8.encode(this);
    // for (var i = 0; i < byteArray.length; i++) {
    //   byteArray[i] = byteArray[i] >> 6;
    // }
    return int.parse(byteArray.sublist(byteArray.length - 4, byteArray.length).join(''));
  }
}

extension GetSchoolFromString on Schools {
  School fromString(String s) => Schools.schools.where((school) => school.schoolName == s).single;
}

extension GetContrastColor on Color {
  Color contrastColor() {
    // Calculate the perceptive luminance (aka luma) - human eye favors green color...
    double luma = ((0.299 * red) + (0.587 * green) + (0.114 * blue)) / 255;

    // Return black for bright colors, white for dark colors
    return luma > 0.75 ? Colors.black : Colors.white;
  }
}
