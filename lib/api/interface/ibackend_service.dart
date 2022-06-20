import 'package:flutter/foundation.dart';

@immutable
abstract class IBackendService {
  /// [HttpGet]
  Future<dynamic> getSchedule(
      String scheduleId, String startTag, String defaultSchool);

  /// [HttpGet]
  Future<dynamic> getPrograms(String searchQuery, String defaultSchool);
}
