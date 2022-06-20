import 'package:tumble/database/database.dart';

class DatabaseRepository {
  static var db = MyDatabase();

  addScheduleEntry(ScheduleCompanion scheduleItem) =>
      db.insertSchedule(scheduleItem);

  Future<int> deleteSchedules(String scheduleId) =>
      db.deleteSchedule(scheduleId);

  Future<List<ScheduleData>?> getAllScheduleEntries() => db.getAllSchedules();

  Future<ScheduleData?> getScheduleEntry(String scheduleId) =>
      db.getSchedule(scheduleId);

  Future<DateTime?> getScheduleCachedTime(String scheduleId) =>
      db.getScheduleCachedTime(scheduleId);

  Future<int?> deleteAllSchedules() => db.deleteAllSchedules();

  Future<List<String>?> getAllDatabaseScheduleIds() =>
      db.getAllDatabaseScheduleIds();

  Future<List<String>?> getGeneratedUuids(String scheduleId) =>
      db.getGeneratedUuids(scheduleId);

  Future<void> updateSchedules(ScheduleCompanion newSchedule) =>
      db.updateSchedules(newSchedule);

  Future<String> currentDefaultSchedule() => db.currentDefaultSchedule();

  Future<List<ScheduleData>?> getAllScheduleEntriesWithoutUuid() =>
      db.getAllScheduleEntriesWithoutUuid();

  Future<bool> hasFavoriteSchedule() => db.hasFavoriteSchedule();

  Future<void> addPreferences(PreferenceData preferenceData) =>
      db.addPreferences(preferenceData);

  Future<PreferenceData?> getPreferences() => db.getPreferences();

  Future<int> updatePreferences(String target) =>
      db.updatePreferencesSchool(target);

  Future<bool> hasDefaultSchool() => db.hasDefaultSchool();

  Future<int> getDefaultViewType() => db.getDefaultViewType();

  Future<String> getDefaultSchool() => db.getDefaultSchool();
}
