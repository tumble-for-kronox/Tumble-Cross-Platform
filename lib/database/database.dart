import 'dart:developer';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;

import 'interface/idatabase_service.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {'tables.drift'},
)
class MyDatabase extends _$MyDatabase implements IDatabaseService {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Insert a schedule
  @override
  Future<int> insertSchedule(ScheduleCompanion scheduleItem) async {
    return await into(schedule).insert(scheduleItem);
  }

  // Get a specific schedule
  @override
  Future<ScheduleData?> getSchedule(String scheduleId) async {
    return await (select(schedule)
          ..where((scheduleTbl) => scheduleTbl.id.equals(scheduleId)))
        .getSingleOrNull();
  }

  // Delete schedule
  @override
  Future<int> deleteSchedule(String scheduleId) async {
    return await (delete(schedule)
          ..where((scheduleTbl) => scheduleTbl.id.equals(scheduleId)))
        .go();
  }

  // Get all schedules
  @override
  Future<List<ScheduleData>> getAllSchedules() async {
    return await select(schedule).get();
  }

  @override
  Future<String> currentDefaultSchedule() async {
    return (await select(preferences).getSingle()).defaultSchedule;
  }

  @override
  Future<int?> deleteAllSchedules() {
    // TODO: implement deleteAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<String>?> getAllDatabaseScheduleIds() {
    // TODO: implement getAllDatabaseScheduleIds
    throw UnimplementedError();
  }

  @override
  Future<List<ScheduleData>?> getAllDatabaseScheduleNames() {
    // TODO: implement getAllDatabaseScheduleNames
    throw UnimplementedError();
  }

  @override
  Future<List<ScheduleData>?> getAllScheduleEntriesWithoutUuid() {
    // TODO: implement getAllScheduleEntriesWithoutUuid
    throw UnimplementedError();
  }

  @override
  Future<List<String>?> getGeneratedUuids(String scheduleId) {
    // TODO: implement getGeneratedUuids
    throw UnimplementedError();
  }

  @override
  Future<DateTime?> getScheduleCachedTime(String scheduleId) {
    // TODO: implement getScheduleCachedTime
    throw UnimplementedError();
  }

  @override
  Future<void> updateSchedules(ScheduleCompanion newSchedule) {
    // TODO: implement updateSchedules
    throw UnimplementedError();
  }

  @override
  Future<bool> hasFavoriteSchedule() async {
    return (await select(schedule).get()).isNotEmpty;
  }

  @override
  Future<int> addPreferences(PreferenceData preferenceData) async {
    log("AddPreferences");
    return await into(preferences).insert(preferenceData);
  }

  @override
  Future<PreferenceData?> getPreferences() async {
    return await select(preferences).getSingleOrNull();
  }

  @override
  Future<int> updatePreferencesSchool(String target) async {
    log("UpdatePreferences");
    return await (update(preferences)
          ..where((t) => t.defaultSchool.isNotNull()))
        .write(
      PreferencesCompanion(
        defaultSchool: Value(target),
      ),
    );
  }

  @override
  Future<bool> hasDefaultSchool() async {
    var res = (await select(preferences).get());
    return res.isNotEmpty;
  }

  @override
  Future<int> getDefaultViewType() async {
    return (await select(preferences).getSingle()).viewType;
  }

  @override
  Future<String> getDefaultSchool() async {
    return (await select(preferences).getSingle()).defaultSchool;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFold = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFold.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
