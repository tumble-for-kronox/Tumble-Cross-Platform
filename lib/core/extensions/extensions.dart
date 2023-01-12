import 'dart:convert';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:tumble/core/api/backend/data/endpoints.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/database/repository/database_service.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/theme/color_picker.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';

extension ScheduleParsing on ScheduleModel {
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
  int encodeUniqueIdentifier() => hashCode;
}

extension GetSchoolFromString on Schools {
  School fromString(String s) =>
      Schools.schools.where((school) => school.schoolName == s).single;
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
        .map((weekNumberToDayList) => Week(
            weekNumber: weekNumberToDayList.key,
            days: weekNumberToDayList.value))
        .toList();
  }
}

extension StringParsing on NavbarItem {
  String toStringTitle() {
    switch (this) {
      case NavbarItem.search:
        return S.searchPage.title().toUpperCase();
      case NavbarItem.list:
        return S.listViewPage.title().toUpperCase();
      case NavbarItem.week:
        return S.weekViewPage.title().toUpperCase();
      case NavbarItem.calendar:
        return S.calendarViewPage.title().toUpperCase();
      case NavbarItem.overview:
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

extension AutoRefreshSessionUserResp on ApiResponse {
  Future<ApiResponse> autoRefreshSession(
      Future<ApiResponse> Function(String refreshToken) refreshSession,
      KronoxUserModel session) async {
    if (status != ApiResponseStatus.completed ||
        status != ApiResponseStatus.success) {
      log(name: 'auto_refresh', 'Logging user in again...');
      return await refreshSession(session.refreshToken);
    }

    return ApiResponse.authorized(session);
  }
}

extension AutoRefreshSessionBookingResp on ApiResponse {
  Future<ApiResponse> autoRefreshSession(
      Future<ApiResponse> Function(String refreshToken) refreshSession,
      KronoxUserModel session) async {
    if (status != ApiResponseStatus.success) {
      log(name: 'auto_refresh', 'Logging user in again...');
      return await refreshSession(session.refreshToken);
    }

    return ApiResponse.authorized(session);
  }
}

extension FilterSetNotifications on AwesomeNotifications {
  Future<List<NotificationModel>> getAllNotificationsFromChannels(
      List<String> channels) async {
    return (await listScheduledNotifications())
        .where((notification) =>
            channels.contains(notification.content!.channelKey!))
        .toList();
  }

  Future<List<NotificationModel>> getAllNotificationsExceptFromChannels(
      List<String> channels) async {
    return (await listScheduledNotifications())
        .where((notification) =>
            !channels.contains(notification.content!.channelKey!))
        .toList();
  }
}
