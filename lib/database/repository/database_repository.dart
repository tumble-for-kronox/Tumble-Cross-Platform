import 'dart:developer';

import 'package:sembast/sembast.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/interface/iaccess_stores.dart';
import 'package:tumble/database/interface/idatabase_service.dart';
import 'package:tumble/models/api_models/kronox_user_model.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

class DatabaseRepository implements IDatabaseScheduleService {
  final _scheduleStore = intMapStoreFactory.store(AccessStores.SCHEDULE_STORE);
  final _userStore = intMapStoreFactory.store(AccessStores.USER_STORE);

  Future<Database> get _db async => await locator<AppDatabase>().database;

  @override
  Future addSchedule(ScheduleModel scheduleModel) async {
    await _scheduleStore.add(await _db, scheduleModelToJson(scheduleModel));
    log('Added schedule');
  }

  @override
  Future removeSchedule(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    await _scheduleStore.delete(await _db, finder: finder);
    log('Removed schedule');
  }

  @override
  Future updateSchedule(ScheduleModel scheduleModel) async {
    final finder = Finder(filter: Filter.byKey(scheduleModel.id));
    await _scheduleStore.update(await _db, scheduleModel.toJson(), finder: finder);
  }

  @override
  Future<List<ScheduleModel>> getAllSchedules() async {
    final recordSnapshots = await _scheduleStore.find(await _db);
    return recordSnapshots.map((snapshot) => ScheduleModel.fromJson(snapshot.value)).toList();
  }

  @override
  Future<ScheduleModel?> getOneSchedule(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot = await _scheduleStore.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      return ScheduleModel.fromJson(recordSnapshot.value);
    }
    return null;
  }

  @override
  Future<List<String>> getAllScheduleIds() async {
    final recordSnapshots = await _scheduleStore.find(await _db);
    return recordSnapshots.map((snapshot) => ScheduleModel.fromJson(snapshot.value).id).toList();
  }

  @override
  Future removeAllSchedules() async {
    _scheduleStore.delete(await _db);
  }

  @override
  Future setUserSession(KronoxUserModel kronoxUser) async {
    await _userStore.add(await _db, kronoxUserModelToJson(kronoxUser));
    log('Added user');
  }

  @override
  Future removeUserSession() async {
    await _userStore.delete(await _db);
    log('Deleted all user data');
  }

  @override
  Future<KronoxUserModel?> getUserSession() async {
    final sessionSnapshot = await _userStore.findFirst(await _db);
    if (sessionSnapshot == null) {
      log("User not found in store.");
      return null;
    }
    log("User found in store.");
    return KronoxUserModel.fromJson(sessionSnapshot.value);
  }
}
