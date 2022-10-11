import 'dart:convert';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/theme/color_picker.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';

extension ScheduleParsing on ScheduleModel {
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
  String capitalize() {
    if (length > 0) {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    }
    return "(${S.runtimeError.missingTitle()})";
  }

  String humanize() {
    List<String> stringFragments = split('_');
    for (int i = 0; i < stringFragments.length; i++) {
      stringFragments[i] = stringFragments[i].capitalize();
    }
    return stringFragments.join(' ');
  }

  /// Used to give notifications unique id's based on event id
  int encodeUniqueIdentifier() {
    List<int> byteArray = utf8.encode(this);
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
    return luma > 0.65 ? Colors.black : Colors.white;
  }
}

extension SplitToWeek on List<Day> {
  List<Week> splitToWeek() {
    return groupBy(this, (Day day) => day.weekNumber)
        .entries
        .map((weekNumberToDayList) => Week(weekNumber: weekNumberToDayList.key, days: weekNumberToDayList.value))
        .toList();
  }
}

extension StringParsing on NavbarItem {
  String toStringTitle() {
    switch (this) {
      case NavbarItem.SEARCH:
        return S.searchPage.title().toUpperCase();
      case NavbarItem.LIST:
        return S.listViewPage.title().toUpperCase();
      case NavbarItem.WEEK:
        return S.weekViewPage.title().toUpperCase();
      case NavbarItem.CALENDAR:
        return S.calendarViewPage.title().toUpperCase();
      case NavbarItem.USER_OVERVIEW:
        return S.authorizedPage.title().toUpperCase();
    }
  }
}

extension ListCopyAndUpdate on List<bool> {
  List<bool> copyAndUpdate(int index, bool value) {
    List<bool> tempCopyList = [...this];
    tempCopyList[index] = value;
    return tempCopyList;
  }
}
