import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:food_app/database/app_dbinfo.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:sqflite/sqflite.dart';

class AppDB {
  late Database _db;

  AppDB._privateConstructor();

  static final AppDB instance = AppDB._privateConstructor();

  Database getDatabase() {
    return _db;
  }

  Future openDB() async {
    Directory userDirectory = await getApplicationDocumentsDirectory();
    String path = join(userDirectory.path, AppDatabaseInfo.databaseName);
    'path =>>${path.toString()}'.toLog;

    // await deleteDatabase(path);

    await openDatabase(path, version: AppDatabaseInfo.databaseVersion)
        .then((db) async {
      _db = db;
      'db open.'.toLog;

      await AppDatabaseInfo().initDb(_db);
    }).catchError((error) {
      'Error while tring to open db: $error'.toErrorLog;
    });
  }

  Future close() async => _db.close();
}
