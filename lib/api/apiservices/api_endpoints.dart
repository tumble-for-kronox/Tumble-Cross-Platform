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

  // Query parameters
  static const String school = 'schoolId';
  static const String startTag = 'startTag';
  static const String search = 'searchQuery';
}
