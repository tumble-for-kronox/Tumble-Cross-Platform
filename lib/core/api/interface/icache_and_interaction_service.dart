import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/database/database_response.dart';

@immutable
abstract class ICacheAndInteractionService {
  Future<ApiScheduleOrProgrammeResponse> programSearchDispatcher(
      String searchQuery);

  Future<ApiScheduleOrProgrammeResponse> scheduleFetchDispatcher(
      String scheduleId);

  Future<ApiScheduleOrProgrammeResponse> getCachedOrNewSchedule(
      String scheduleId);

  Future<SharedPreferenceResponse> verifyDefaultSchoolExists();
}
