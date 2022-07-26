import 'package:flutter/foundation.dart';

@immutable
class ApiEndPoints {
  // Endpoints
  static const String debugBaseUrl = '192.168.0.172:7036';
  static const String baseUrl = '';
  static const String getSchedules = '/schedules/search';
  static const String getOneSchedule = '/schedules/';

  // other stuff
  static const String school = 'schoolId';
  static const String startTag = 'startTag';
  static const String search = 'searchQuery';
}
