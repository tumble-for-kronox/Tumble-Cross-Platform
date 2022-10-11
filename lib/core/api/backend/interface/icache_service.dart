import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/backend/response_types/schedule_or_programme_response.dart';
import 'package:tumble/core/api/database/shared_preference_response.dart';

@immutable
abstract class ICacheService {
  Future<ScheduleOrProgrammeResponse> searchProgram(String searchQuery);

  Future<ScheduleOrProgrammeResponse> updateSchedule(String scheduleId);

  Future<ScheduleOrProgrammeResponse> findSchedule(String scheduleId);

  Future<SharedPreferenceResponse> hasSchool();
}
