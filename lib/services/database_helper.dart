import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/settingsdb.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper.internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "notes.db");

    bool exists = await databaseExists(path);

    if (!exists) {
      print("Assetden yeni bir kopya oluşturuluyor");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "notes.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Olan db açılıyor");
    }

    return await openDatabase(path, readOnly: false);
  }

  Future<SettingsDb> getSettings() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> settingsMapList =
        await db.rawQuery("SELECT * FROM settings");
    return SettingsDb.fromMap(settingsMapList[0]);
  }
}
