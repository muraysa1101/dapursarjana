import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;
  Future<Database> openDb() async {
    var databasePath = await getDatabasesPath();

    try {
      await Directory(databasePath).create(recursive: true);
    } catch (error) {
      print("Error Database : $error");
    }

    var path = join(databasePath, "near_deal.db");
    _database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      var createCartTable = '''
        CREATE TABLE IF NOT EXISTS cart(
          id INTEGER PRIMARY KEY NOT NULL,
          product_id TEXT(20),
          product_name TEXT(100),
          photo TEXT(100),
          price INTEGER
        );
        ''';

      await db.execute(createCartTable);

      var createFavTable = '''
        CREATE TABLE IF NOT EXISTS favorite(
          id INTEGER PRIMARY KEY NOT NULL,
          product_id TEXT(20),
          product_name TEXT(100),
          photo TEXT(100),
          price INTEGER
        );
        ''';

      await db.execute(createFavTable);
    });

    return _database;
  }

  Future<void> closeDb() {
    return _database.close();
  }
}
