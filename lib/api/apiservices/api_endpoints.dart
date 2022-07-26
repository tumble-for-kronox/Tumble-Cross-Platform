import 'package:flutter/foundation.dart';

@immutable
class ApiEndPoints {
  // Endpoints
  static const String debugBaseUrl = '10.0.2.2:7036';
  static const String baseUrl = '';
  static const String getSchedules = '/schedules/search';
  static const String getOneSchedule = '/schedules/';

  // Query parameters
  static const String school = 'schoolId';
  static const String startTag = 'startTag';
  static const String search = 'searchQuery';
}
