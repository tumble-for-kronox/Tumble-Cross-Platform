import 'dart:async';
import 'dart:developer';
import 'package:flutter/animation.dart';
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
import 'package:tumble/core/ui/schedule/utils/day_list_builder.dart';

class AppDatabase {
  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  final _scheduleStore = intMapStoreFactory.store(AccessStores.SCHEDULE_STORE);

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
    log(oldVersion.toString());
    if (oldVersion < 2) {
      List<String>? bookmarks = getIt<PreferenceRepository>().bookmarkIds;
      if (bookmarks != null) {
        for (String id in bookmarks) {
          final finder = Finder(filter: Filter.equals("id", id));
          final recordSnapshot = await _scheduleStore.findFirst(db, finder: finder);
          if (recordSnapshot != null) {
            final ScheduleModel scheduleModel = ScheduleModel.fromJson(recordSnapshot.value);
            final ScheduleModel newScheduleModel = ScheduleModel(
                cachedAt: scheduleModel.cachedAt,
                id: scheduleModel.id,
                days: await DayListBuilder.buildListOfDays(newVersion, getIt<DatabaseRepository>()));
            (await _scheduleStore.update(db, newScheduleModel.toJson(), finder: finder));
          }

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
