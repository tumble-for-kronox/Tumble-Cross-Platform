import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';

@immutable
abstract class ICacheService {
  Future<ApiResponse> searchProgram(String searchQuery);

  Future<ApiResponse> updateSchedule(String scheduleId);

  Future<ApiResponse> findSchedule(String scheduleId);

  bool get schoolNotNull;

  Future<void> permissionRequest(bool value);

  bool checkFirstTimeLaunch();

  Future<void> setFirstTimeLaunched(bool hasRun);

  Future<void> changeSchool(String schoolName);

  bool get notificationCheck;
}
