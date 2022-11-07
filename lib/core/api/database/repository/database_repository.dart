import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';
import 'package:tumble/core/api/database/app_database.dart';
import 'package:tumble/core/api/database/data/access_stores.dart';
import 'package:tumble/core/api/database/interface/idatabase_service.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class DatabaseRepository implements IDatabaseService {
  final _scheduleStore = intMapStoreFactory.store(AccessStores.SCHEDULE_STORE);
  final _userStore = intMapStoreFactory.store(AccessStores.USER_STORE);
  final _colorStore = intMapStoreFactory.store(AccessStores.COLOR_STORE);
  final String _id = 'id';

  Future<Database> get _db async => await getIt<AppDatabase>().database;

  @override
  Future<void> add(dynamic scheduleModel) async {
    await _scheduleStore.add(await _db, scheduleModelToJson(scheduleModel));
  }

  @override
  Future<void> remove(String id, String accessStore) async {
    final store = intMapStoreFactory.store(accessStore);
    final finder = Finder(filter: Filter.equals(_id, id));
    await store.delete(await _db, finder: finder);
  }

  @override
  Future<void> update(dynamic scheduleModel) async {
    final finder = Finder(filter: Filter.equals(_id, scheduleModel.id));
    (await _scheduleStore.update(await _db, scheduleModel.toJson(), finder: finder));
  }

  @override
  Future removeAll() async {
    await _scheduleStore.delete(await _db);
    log('Removed all cached schedules');
  }

  @override
  Future<List<ScheduleModel>> getAll() async {
    final recordSnapshots = await _scheduleStore.find(await _db);
    return recordSnapshots.map((snapshot) => ScheduleModel.fromJson(snapshot.value)).toList();
  }

  @override
  Future<ScheduleModel?> getOneSchedule(String id) async {
    final finder = Finder(filter: Filter.equals(_id, id));
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
  Future setUserSession(KronoxUserModel kronoxUser) async {
    await _userStore.add(await _db, kronoxUserModelToJson(kronoxUser));
  }

  @override
  Future removeUserSession() async {
    await _userStore.delete(await _db);
  }

  @override
  Future<KronoxUserModel?> getUserSession() async {
    final sessionSnapshot = await _userStore.findFirst(await _db);
    if (sessionSnapshot == null) {
      return null;
    }
    return KronoxUserModel.fromJson(sessionSnapshot.value);
  }

  Future<Color?> getCourseColor(String courseId) async {
    final courseColors = await _colorStore.findFirst(await _db) as Map<String, int>?;
    if (courseColors == null) return null;
    return Color(courseColors[courseId]!);
  }

  Future<Map<String, int>> getCourseColors() async {
    final snapshot = (await _colorStore.find(await _db));
    if (snapshot.isEmpty) {
      return <String, int>{};
    }
    return cloneMap(snapshot.first.value).cast<String, int>();
  }

  Future<Map<String, int>> updateCourseColor(String courseId, int color) async {
    Map<String, int> courseColors = await getCourseColors();
    courseColors[courseId] = color;
    await _colorStore.delete(await _db);
    await _colorStore.record(AccessStores.COLOR_ENTRY_KEY).add(await _db, courseColors);
    return courseColors;
  }

  @override
  Future<Stream<Map<String, int>>> getColorStream() {
    return _db.then((db) => _colorStore
        .record(AccessStores.COLOR_ENTRY_KEY)
        .onSnapshot(db)
        .map((snapshot) => cloneMap(snapshot!.value).cast<String, int>()).asBroadcastStream());
  }
}
