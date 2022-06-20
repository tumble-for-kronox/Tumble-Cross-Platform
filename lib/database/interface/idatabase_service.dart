import 'package:flutter/foundation.dart';
import 'package:tumble/database/database.dart';

@immutable
abstract class IDatabaseService {
  /// [Schedule] table
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Future<int> insertSchedule(ScheduleCompanion scheduleItem);

  Future<ScheduleData?> getSchedule(String scheduleId);

  Future<int> deleteSchedule(String scheduleId);

  Future<List<ScheduleData>> getAllSchedules();

  Future<int?> deleteAllSchedules();

  Future<DateTime?> getScheduleCachedTime(String scheduleId);

  Future<List<String>?> getAllDatabaseScheduleIds();

  Future<List<String>?> getGeneratedUuids(String scheduleId);

  Future<void> updateSchedules(ScheduleCompanion newSchedule);

  Future<String> currentDefaultSchedule();

  Future<List<ScheduleData>?> getAllScheduleEntriesWithoutUuid();

  Future<bool> hasFavoriteSchedule();

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// [Preferences] table
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Future<void> addPreferences(PreferenceData preferencesCompanion);

  Future<PreferenceData?> getPreferences();

  Future<int> updatePreferencesSchool(String target);

  Future<bool> hasDefaultSchool();

  Future<int> getDefaultViewType();

  Future<String> getDefaultSchool();

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
}
