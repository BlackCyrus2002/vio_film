import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vio_film/model/favorites_model.dart';

import '../model/user_model.dart';

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

    await database.execute('''
    CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    number TEXT NOT NULL,
    email TEXT NOT NULL,
    image TEXT
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
        'state': 1,
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

  //Gestion de l'utilisateur

  Future<List<UserModel>> takeUser() async {
    Database db = await database;
    List<Map<String, dynamic>> userMaps = await db.query('users');
    return userMaps.map((user) => UserModel.fromMap(user)).toList();
  }

  Future<bool> addUser(
    String name,
    String number,
    String email,
    String? image,
  ) async {
    Database db = await database;
    await db.insert('users', {
      'name': name,
      'number': number,
      'email': email,
      'image': image,
    });
    return true;
  }

  Future<UserModel> oneUser() async {
    Database db = await database;
    List<Map<String, dynamic>> userMaps = await db.query('users');
    return UserModel.fromMap(userMaps.first);
  }

  Future<bool> updateUser(
      int id,
    String name,
    String number,
    String email,
    String? image,
  ) async {
    Database db = await database;
    await db.update(
      "users",
      {"name": name, "number": number, "email": email, "image": image},
      where: "id = ?",
      whereArgs: [id],
    );
    return true;
  }
}
