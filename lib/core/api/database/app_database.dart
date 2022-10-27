import 'dart:async';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/database/data/access_stores.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/theme/color_picker.dart';

class AppDatabase {
  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  final _scheduleStore = intMapStoreFactory.store(AccessStores.SCHEDULE_STORE);
  final _userStore = intMapStoreFactory.store(AccessStores.USER_STORE);

  // Database object accessor
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'tumble_user_db.db');
    final database = await databaseFactoryIo.openDatabase(
      dbPath,
      version: 2,
      onVersionChanged: (db, oldVersion, newVersion) async => _updateDatabase(db, oldVersion, newVersion),
    );
    _dbOpenCompleter!.complete(database);
  }

  Future<void> _updateDatabase(db, oldVersion, newVersion) async {
    Map<String, int> courses = {};
    if (oldVersion < 2) {
      List<String>? bookmarks = getIt<PreferenceRepository>().bookmarkIds;
      if (bookmarks != null) {
        for (String id in bookmarks) {
          final finder = Finder(filter: Filter.equals("id", id));
          final recordSnapshot = await _scheduleStore.findFirst(db, finder: finder);
          final ScheduleModel scheduleModel = ScheduleModel.fromJson(recordSnapshot!.value);
          final ScheduleModel newScheduleModel = ScheduleModel(
              cachedAt: scheduleModel.cachedAt,
              id: scheduleModel.id,
              days: scheduleModel.days
                  .map((day) => Day(
                      name: day.name,
                      date: day.date,
                      isoString: day.isoString,
                      weekNumber: day.weekNumber,
                      events: day.events
                          .map((event) => Event(
                              id: event.id,
                              title: event.title,
                              course: () {
                                /// Dynamically assign course colors
                                if (!courses.containsKey(event.course.id)) {
                                  courses[event.course.id] = ColorPicker().getRandomHexColor();
                                  return Course(
                                      id: event.course.id,
                                      swedishName: event.course.swedishName,
                                      englishName: event.course.englishName,
                                      courseColor: courses[event.course.id]);
                                }
                                return Course(
                                    id: event.course.id,
                                    swedishName: event.course.swedishName,
                                    englishName: event.course.englishName,
                                    courseColor: courses[event.course.id]);
                              }(),
                              from: event.from,
                              to: event.to,
                              locations: event.locations,
                              teachers: event.teachers,
                              isSpecial: event.isSpecial,
                              lastModified: event.lastModified))
                          .toList()))
                  .toList());
          (await _scheduleStore.update(db, newScheduleModel.toJson(), finder: finder));
          log(name: 'app_database', 'Udpated database on version change to version $newVersion');
        }
      }
      await intMapStoreFactory
          .store('course_colors')
          .delete(db)
          .then((value) => log(name: 'app_database', 'Deleted old course color system'));
    }
  }
}
