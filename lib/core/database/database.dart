import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

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
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }
}
