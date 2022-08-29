import 'dart:io';

import 'package:flutter/foundation.dart';

@immutable
class ApiEndPoints {
  // Endpoints
  static String debugBaseUrl =
      Platform.isAndroid ? '10.0.2.2:7036' : 'localhost:7036';
  static const String baseUrl = '';
  static const String getSchedules = '/schedules/search';
  static const String getOneSchedule = '/schedules/';
  static const String postUserLogin = 'users/login';
  static const String getUserEvents = 'users/events';
  static const String getRefreshSession = 'users/refresh';
  static const String putRegisterAll = 'users/events/register/all';
  static const String putRegisterEvent = 'users/events/register/';
  static const String putUnregisterEvent = 'users/events/unregister/';
  static const String postSubmitIssue = '/misc/submitIssue';

  // Path parameters
  static const String eventId = 'eventId';

  // Query parameters
  static const String school = 'schoolId';
  static const String startTag = 'startTag';
  static const String search = 'searchQuery';
  static const String sessionToken = 'sessionToken';

  // Body parameters
  static const String password = 'password';
  static const String username = 'username';

  // Issue body parameters
  static const String issueSubject = 'title';
  static const String issueBody = 'description';
}
