import 'package:sembast/sembast.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/interface/iaccess_stores.dart';
import 'package:tumble/database/interface/idatabase_service.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

class DatabaseRepository implements IDatabaseScheduleService {
  final _scheduleStore = intMapStoreFactory.store(AccessStores.SCHEDULE_STORE);

  Future<Database> get _db async => await locator<AppDatabase>().database;

  @override
  Future addSchedule(ScheduleModel scheduleModel) async {
    await _scheduleStore.add(await _db, scheduleModel.toJson());
  }

  @override
  Future removeSchedule(String id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _scheduleStore.delete(await _db, finder: finder);
  }

  @override
  Future updateSchedule(ScheduleModel scheduleModel) async {
    final finder = Finder(filter: Filter.byKey(scheduleModel.id));
    await _scheduleStore.update(await _db, scheduleModel.toJson(),
        finder: finder);
  }

  @override
  Future<List<ScheduleModel>> getAllSchedules() async {
    final recordSnapshots = await _scheduleStore.find(await _db);
    return recordSnapshots
        .map((snapshot) => ScheduleModel.fromJson(snapshot.value))
        .toList();
  }

  @override
  Future<ScheduleModel?> getOneSchedule(String id) async {
    final finder = Finder(filter: Filter.byKey(id));
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
}
