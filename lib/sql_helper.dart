import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      studentId INTEGER,
      domain TEXT,
      batch INTEGER,
      image TEXT,
      place TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    //final dbPath = await sql.getDatabasesPath();
    return 
    
     sql.openDatabase(
      "dbestech.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("...creating a table ....");
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String name, dynamic studentId, String domain,
      dynamic batch, String? imagePath,dynamic place) async {
    final db = await SqlHelper.db();
    final data = {
      'name': name,
      'studentId': studentId,
      'domain': domain,
      'batch': batch,
      'place':place,
      'image': imagePath ?? '',
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SqlHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SqlHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String name, dynamic studentId,
      String domain, dynamic batch,dynamic place, String? imagePath) async {
    final db = await SqlHelper.db();
    final data = {
      'name': name,
      'studentId': studentId,
      'domain': domain,
      'batch': batch,
      'place':place,
      'image': imagePath ?? '',
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SqlHelper.db();
    try {
      await db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("something went wrong when deleting an item:$err");
    }
  }
}
