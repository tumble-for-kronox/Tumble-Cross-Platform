import 'dart:developer';
import 'dart:ui';
import 'package:sembast/sembast.dart';
import 'package:tumble/core/database/database.dart';
import 'package:tumble/core/database/data/access_stores.dart';
import 'package:tumble/core/database/interface/idatabase_service.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class DatabaseRepository implements IDatabaseScheduleService {
  final _scheduleStore = intMapStoreFactory.store(AccessStores.SCHEDULE_STORE);
  final _userStore = intMapStoreFactory.store(AccessStores.USER_STORE);
  final _courseColorStore =
      intMapStoreFactory.store(AccessStores.COURSE_COLOR_STORE);

  Future<Database> get _db async => await getIt<AppDatabase>().database;

  @override
  Future<void> add(dynamic scheduleModel) async {
    await _scheduleStore.add(await _db, scheduleModelToJson(scheduleModel));
  }

  @override
  Future<void> remove(String id, String accessStores) async {
    switch (accessStores) {
      case AccessStores.USER_STORE:
        final finder = Finder(filter: Filter.equals('id', id));
        await _userStore.delete(await _db, finder: finder);
        break;
      case AccessStores.COURSE_COLOR_STORE:
        final finder = Finder(filter: Filter.equals('scheduleId', id));
        await _courseColorStore.delete(await _db, finder: finder);
        break;
      case AccessStores.SCHEDULE_STORE:
        final finder = Finder(filter: Filter.equals('id', id));
        await _scheduleStore.delete(await _db, finder: finder);
        break;
    }
  }

  @override
  Future<void> update(dynamic scheduleModel) async {
    final finder = Finder(filter: Filter.equals("id", scheduleModel.id));
    (await _scheduleStore.update(await _db, scheduleModel.toJson(),
        finder: finder));
  }

  @override
  Future removeAll() async {
    await _scheduleStore.delete(await _db);
    log('Removed all cached schedules');
  }

  @override
  Future<List<ScheduleModel>> getAll() async {
    final recordSnapshots = await _scheduleStore.find(await _db);
    return recordSnapshots
        .map((snapshot) => ScheduleModel.fromJson(snapshot.value))
        .toList();
  }

  /* ------------------- Repository specific methods ---------------------- */

  @override
  Future<ScheduleModel?> getOneSchedule(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot =
        await _scheduleStore.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      return ScheduleModel.fromJson(recordSnapshot.value);
    }
    return null;
  }

  @override
  Future<List<String>> getAllScheduleIds() async {
    final recordSnapshots = await _scheduleStore.find(await _db);
    return recordSnapshots
        .map((snapshot) => ScheduleModel.fromJson(snapshot.value).id)
        .toList();
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

  @override
  Future updateCourseInstance(CourseUiModel courseUiModel) async {
    await _courseColorStore.update(
        await _db, courseUiModelToJson(courseUiModel),
        finder:
            Finder(filter: Filter.equals('courseId', courseUiModel.courseId)));
    log("updateCourseInstance successfully called on id  --> ${courseUiModel.courseId}");
  }

  @override
  Future addCourseInstance(CourseUiModel courseUiModel) async {
    await _courseColorStore.add(await _db, courseUiModelToJson(courseUiModel));
    log("addCourseInstance sucessfully called on id --> ${courseUiModel.toString()}");
  }

  @override
  Future<Color> getCourseColor(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot =
        await _courseColorStore.findFirst(await _db, finder: finder);
    Color color = Color(CourseUiModel.fromJson(recordSnapshot!.value).color);
    log("getCourseColor sucessfully called called on id --> $id");
    return color;
  }

  @override
  Future<List<String>> getAllCachedCourses() async {
    final recordSnapshots = await _courseColorStore.find(await _db);
    return recordSnapshots
        .map((snapshot) => CourseUiModel.fromJson(snapshot.value).courseId)
        .toList();
  }

  @override
  Future removeAllCachedCourseColors() async {
    await _courseColorStore.delete(await _db);
    log('Removed all cached course colors');
  }

  @override
  Future<List<CourseUiModel>> getCachedCoursesFromId(String scheduleId) async {
    final finder = Finder(filter: Filter.equals('scheduleId', scheduleId));
    final recordSnapshot =
        await _courseColorStore.find(await _db, finder: finder);
    return recordSnapshot
        .map((snapshot) => CourseUiModel.fromJson(snapshot.value))
        .toList();
  }
}
