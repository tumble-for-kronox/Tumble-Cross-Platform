import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';

import '../api/backend/response_types/user_response.dart';

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
  int encodeUniqueIdentifier() {
    return hashCode;
    // List<int> byteArray = utf8.encode(this);
    // return int.parse(byteArray.sublist(byteArray.length - 4, byteArray.length).join(''));
  }
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

extension AutoRefreshSessionUserResp on UserResponse {
  Future<UserResponse> autoRefreshSession(
      Future<UserResponse> Function(String refreshToken) refreshSession,
      KronoxUserModel session) async {
    if (status != ApiUserResponseStatus.COMPLETED ||
        status != ApiUserResponseStatus.AUTHORIZED) {
      log(name: 'auto_refresh', 'Logging user in again...');
      return await refreshSession(session.refreshToken);
    }

    return UserResponse.authorized(session);
  }
}

extension AutoRefreshSessionBookingResp on BookingResponse {
  Future<UserResponse> autoRefreshSession(
      Future<UserResponse> Function(String refreshToken) refreshSession,
      KronoxUserModel session) async {
    if (status != ApiBookingResponseStatus.SUCCESS) {
      log(name: 'auto_refresh', 'Logging user in again...');
      return await refreshSession(session.refreshToken);
    }

    return UserResponse.authorized(session);
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
