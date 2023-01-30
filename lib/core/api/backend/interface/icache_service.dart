import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';

@immutable
abstract class ICacheService {
  Future<ScheduleOrProgrammeResponse> searchProgram(String searchQuery);

  Future<ScheduleOrProgrammeResponse> updateSchedule(String scheduleId);

  Future<ScheduleOrProgrammeResponse> findSchedule(String scheduleId);

  bool get schoolNotNull;

  Future<void> permissionRequest(bool value);

  bool checkFirstTimeLaunch();

  Future<void> setFirstTimeLaunched(bool hasRun);

  Future<void> changeSchool(String schoolName);

  bool get notificationCheck;
}
