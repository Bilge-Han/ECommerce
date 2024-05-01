import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperBasket {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE baskets(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        currentPrice DOUBLE,
        originalPrice DOUBLE,
        discount  DOUBLE,
        imageUrl1 TEXT,
        imageUrl2 TEXT,
        category TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Baskets.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
    String name,
    double currentPrice,
    double originalPrice,
    double discount,
    String imageUrl,
    String imageUrl2,
    String category,
  ) async {
    final db = await SQLHelperBasket.db();

    final data = {
      'name': name,
      'currentPrice': currentPrice,
      'originalPrice': originalPrice,
      'discount': discount,
      'imageUrl1': imageUrl,
      'imageUrl2': imageUrl2,
      'category': category,
    };
    final id = await db.insert('baskets', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperBasket.db();
    return db.query('baskets', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperBasket.db();
    return db.query('baskets', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    int id,
    String name,
    double currentPrice,
    double originalPrice,
    double discount,
    String imageUrl,
    String imageUrl2,
    String category,
  ) async {
    final db = await SQLHelperBasket.db();
    final data = {
      'name': name,
      'currentPrice': currentPrice,
      'originalPrice': originalPrice,
      'discount': discount,
      'imageUrl1': imageUrl,
      'imageUrl2': imageUrl2,
      'category': category,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('baskets', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperBasket.db();
    try {
      await db.delete("baskets", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAllItem() async {
    final db = await SQLHelperBasket.db();
    try {
      await db.delete("baskets");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
