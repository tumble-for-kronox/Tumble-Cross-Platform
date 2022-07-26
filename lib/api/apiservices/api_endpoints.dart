import 'package:flutter/foundation.dart';

@immutable
class ApiEndPoints {
  // Endpoints
  static const String baseUrl = 'localhost:7036';
  static const String getSchedules = '/schedules/search/';
  static const String getOneSchedule = '/schedules/';

  // other stuff
  static const String school = 'schoolId';
  static const String startTag = 'startTag';
  static const String search = 'search';
}
