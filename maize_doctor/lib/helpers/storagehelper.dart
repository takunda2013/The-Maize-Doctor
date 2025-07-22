import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageStorageHelper {
  static final ImageStorageHelper _instance = ImageStorageHelper._internal();
  static Database? _database;

  ImageStorageHelper._internal();

  factory ImageStorageHelper() {
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
        profile_image_path TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        image_path TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  // Save image to file system and return path
  Future<String> saveImageToFile(Uint8List imageBytes, String fileName) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final Directory imageDir = Directory('${appDir.path}/images');
    
    // Create images directory if it doesn't exist
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }
    
    final String filePath = '${imageDir.path}/$fileName';
    final File imageFile = File(filePath);
    await imageFile.writeAsBytes(imageBytes);
    
    return filePath;
  }

  // Insert user with image
  Future<int> insertUser(String name, String email, Uint8List? imageBytes) async {
    final db = await database;
    String? imagePath;
    
    if (imageBytes != null) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_profile.jpg';
      imagePath = await saveImageToFile(imageBytes, fileName);
    }
    
    return await db.insert('users', {
      'name': name,
      'email': email,
      'profile_image_path': imagePath,
    });
  }

  // Insert photo
  Future<int> insertPhoto(String title, String description, Uint8List imageBytes) async {
    final db = await database;
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}_photo.jpg';
    final String imagePath = await saveImageToFile(imageBytes, fileName);
    
    return await db.insert('photos', {
      'title': title,
      'description': description,
      'image_path': imagePath,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Get image bytes from file path
  Future<Uint8List?> getImageBytes(String? imagePath) async {
    if (imagePath == null) return null;
    
    final File imageFile = File(imagePath);
    if (await imageFile.exists()) {
      return await imageFile.readAsBytes();
    }
    return null;
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
    String? imagePath;
    
    if (imageBytes != null) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_profile.jpg';
      imagePath = await saveImageToFile(imageBytes, fileName);
    }
    
    return await db.update(
      'users',
      {
        'name': name,
        'email': email,
        'profile_image_path': imagePath,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete user and associated image file
  Future<int> deleteUser(int id) async {
    final db = await database;
    
    // Get user data first to delete image file
    final userData = await getUserById(id);
    if (userData != null && userData['profile_image_path'] != null) {
      final File imageFile = File(userData['profile_image_path']);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
    }
    
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete photo and associated image file
  Future<int> deletePhoto(int id) async {
    final db = await database;
    
    // Get photo data first to delete image file
    List<Map<String, dynamic>> result = await db.query(
      'photos',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (result.isNotEmpty) {
      final String imagePath = result.first['image_path'];
      final File imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
    }
    
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