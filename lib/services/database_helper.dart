import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mr_note_clone/models/category.dart';
import 'package:mr_note_clone/models/note.dart';
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

  Future<List<Category>> getCategoryList() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> categoryMapList = await db.query("category");
    List<Category> categoryList = [];
    for (Map map in categoryMapList) {
      categoryList.add(Category.fromMap(map));
    }
    return categoryList;
  }

  Future<int> addCategory(Category category) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert("category", category.toMap());
    return sonuc;
  }

  Future<int> deleteCategory(int categoryID) async {
    Database db = await _getDatabase();
    int sonuc = await db
        .delete("category", where: "categoryID = ?", whereArgs: [categoryID]);
    return sonuc;
  }

  Future<int> updateCategory(Category category) async {
    Database db = await _getDatabase();
    int sonuc = await db.update("category", category.toMap(),
        where: "categoryID = ?", whereArgs: [category.id]);
    return sonuc;
  }

  String dateFormat(DateTime dt) {
    String month;
    switch (dt.month) {
      case 1:
        month = "Ocak";
        break;
      case 2:
        month = "Şubat";
        break;
      case 3:
        month = "Mart";
        break;
      case 4:
        month = "Nisan";
        break;
      case 5:
        month = "Mayıs";
        break;
      case 6:
        month = "Haziran";
        break;
      case 7:
        month = "Temmuz";
        break;
      case 8:
        month = "Ağustos";
        break;
      case 9:
        month = "Eylül";
        break;
      case 10:
        month = "Ekim";
        break;
      case 11:
        month = "Kasım";
        break;
      case 12:
        month = "Aralık";
        break;
    }
    return month + " " + dt.day.toString() + ", " + dt.year.toString();
  }

  Future<int> isThereAnyTodayNotes(String suan) async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc =
        await db.rawQuery("SELECT COUNT() FROM note WHERE time LIKE '$suan%';");
    return sonuc[0]["COUNT()"];
  }

  Future<int> updateSort(String sort) async {
    Database db = await _getDatabase();
    //"Update settings Set sort = $sort"
    return await db.rawUpdate("update settings Set sort = ?", [sort]);
  }

  Future<int> addNote(Note note) async {
    Database db = await _getDatabase();
    return await db.insert("note", note.toMap());
  }

  Future updateNote(Note note) async {
    Database db = await _getDatabase();
    //Update note Set values Where id = note.id
    return await db
        .update("note", note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }

  Future<List<Note>> getSortNoteList(String suan) async {
    Database db = await _getDatabase();
    List<String> sortList = (await getSettings()).sort.split("/");
    int sortBy = int.parse(sortList[0]);
    int orderBy = int.parse(sortList[1]);
    String query =
        "Select * From note Inner Join category on category.categoryID = "
        "note.categoryID Where time Like '$suan%' order by ";
    switch (sortBy) {
      case 0:
        query += "categoryTitle";
        break;
      case 1:
        query += "noteTitle";
        break;
      case 2:
        query += "content";
        break;
      case 3:
        query += "time";
        break;
      case 4:
        query += "priority";
        break;
    }
    if (orderBy == 0) {
      query += " ASC;";
    } else {
      query += " DESC;";
    }
    List<Map<String, dynamic>> noteMapList = await db.rawQuery(query);
    List<Note> noteList = [];
    for (Map map in noteMapList) {
      noteList.add(Note.fromMap(map));
    }
    return noteList;
  }

  Future<int> deleteNote(int noteID) async {
    Database db = await _getDatabase();
    return await db.delete("note", where: "id = ?", whereArgs: [noteID]);
  }
}
