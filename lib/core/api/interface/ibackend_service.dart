import 'package:flutter/foundation.dart';

@immutable
abstract class IBackendService {
  /// [HttpGet]
  Future<dynamic> getSchedule(String scheduleId, String defaultSchool);

  /// [HttpGet]
  Future<dynamic> getPrograms(String searchQuery, String defaultSchool);

  /// [HttpGet]
  Future<dynamic> getUserEvents(String sessionToken, String defaultSchool);

  /// [HttpGet]
  Future<dynamic> getRefreshSession(String refreshToken, String defaultSchool);

  /// [HttpPost]
  Future<dynamic> postUserLogin(
      String username, String password, String defaultSchool);

  /// [HttpPost]
  Future<dynamic> putRegisterUserEvent(
      String eventId, String sessionToken, String defaultSchool);

  /// [HttpPost]
  Future<dynamic> putUnregisterUserEvent(
      String eventId, String sessionToken, String defaultSchool);
}
