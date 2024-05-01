import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperProduct {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE products(
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
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Productss.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (product)
  static Future<int> createItem(
      String name,
      double currentPrice,
      double originalPrice,
      double discount,
      String imageUrl,
      String imageUrl2,
      String category) async {
    final db = await SQLHelperProduct.db();

    final data = {
      'name': name,
      'currentPrice': currentPrice,
      'originalPrice': originalPrice,
      'discount': discount,
      'imageUrl1': imageUrl,
      'imageUrl2': imageUrl2,
      'category': category
    };
    final id = await db.insert('products', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperProduct.db();
    return db.query('products', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperProduct.db();
    return db.query('products', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id,
      String name,
      double currentPrice,
      double originalPrice,
      double discount,
      String imageUrl,
      String imageUrl2,
      String category) async {
    final db = await SQLHelperProduct.db();

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
        await db.update('products', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperProduct.db();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
