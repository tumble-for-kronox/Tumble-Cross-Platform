import 'dart:async';
import 'dart:developer';
import 'package:flutter/animation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/database/data/access_stores.dart';
import 'package:tumble/core/api/database/repository/database_service.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/theme/color_picker.dart';
import 'package:tumble/core/ui/schedule/utils/day_list_builder.dart';

class AppDatabase {
  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

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
    if (oldVersion < 2) {
      await intMapStoreFactory.store(AccessStores.schedule_store).delete(db);
      await intMapStoreFactory
          .store('course_colors')
          .delete(db)
          .then((value) => log(name: 'app_database', 'Deleted old course color system'));
    }
  }
}
