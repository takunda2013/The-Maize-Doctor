import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app_database.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        profile_image BLOB
      )
    ''');

    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        image_data BLOB NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  // Insert user with image
  Future<int> insertUser(String name, String email, Uint8List? imageBytes) async {
    final db = await database;
    return await db.insert('users', {
      'name': name,
      'email': email,
      'profile_image': imageBytes,
    });
  }

  // Insert photo
  Future<int> insertPhoto(String title, String description, Uint8List imageBytes) async {
    final db = await database;
    return await db.insert('photos', {
      'title': title,
      'description': description,
      'image_data': imageBytes,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get all photos
  Future<List<Map<String, dynamic>>> getAllPhotos() async {
    final db = await database;
    return await db.query('photos', orderBy: 'created_at DESC');
  }

  // Update user
  Future<int> updateUser(int id, String name, String email, Uint8List? imageBytes) async {
    final db = await database;
    return await db.update(
      'users',
      {
        'name': name,
        'email': email,
        'profile_image': imageBytes,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete user
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete photo
  Future<int> deletePhoto(int id) async {
    final db = await database;
    return await db.delete(
      'photos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}