import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vio_film/model/favorites_model.dart';

class DataBaseClient {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "database.bd");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database database, int version) async {
    await database.execute('''
    CREATE TABLE favorites(
    id INTEGER PRIMARY KEY,
    typeID INTEGER NOT NULL,
    type TEXT NOT NULL,
    state INTEGER NOT NULL
    )
    ''');
  }

  Future<bool> addFavorite(int typeID, String type) async {
    Database db = await database;
    List<Map<String, dynamic>> existing = await db.query(
      'favorites',
      where: "typeID = ?",
      whereArgs: [typeID],
    );
    if (existing.isNotEmpty) {
      // S'il existe déjà, on supprime (toggle off)
      await db.delete('favorites', where: "typeID = ?", whereArgs: [typeID]);
    } else {
      // Sinon, on insère (toggle on)
      await db.insert('favorites', {
        "typeID": typeID,
        "type": type,
        'state': 1
      });
    }
    return true;
  }

  Future<List<Favorites>> allFavorites(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> favoritesMaps = await db.query(
      'favorites',
      where: "typeID = ?",
      whereArgs: [id],
    );
    return favoritesMaps
        .map((favorites) => Favorites.fromMap(favorites))
        .toList();
  }

  Future<List<Favorites>> allFavoritesList() async {
    Database db = await database;
    const query = "SELECT * FROM favorites";
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((element) => Favorites.fromMap(element)).toList();
  }
}
