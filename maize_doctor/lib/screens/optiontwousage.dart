import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maize_doctor/helpers/helper.dart';
import 'package:maize_doctor/helpers/storagehelper.dart';

class ImageDatabaseExample extends StatefulWidget {
  @override
  _ImageDatabaseExampleState createState() => _ImageDatabaseExampleState();
}

class _ImageDatabaseExampleState extends State<ImageDatabaseExample> {
  final ImageStorageHelper _dbHelper = ImageStorageHelper();
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _photos = [];

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final photos = await _dbHelper.getAllPhotos();
    setState(() {
      _photos = photos;
    });
  }

  Future<void> _pickAndSaveImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();

      await _dbHelper.insertPhoto(
        'Photo ${DateTime.now().millisecondsSinceEpoch}',
        'Description for photo',
        imageBytes,
      );

      _loadPhotos(); // Refresh the list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Database Example')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndSaveImage,
            child: Text('Pick and Save Image'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                final photo = _photos[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(photo['title']),
                        subtitle: Text(photo['description'] ?? ''),
                      ),
                      FutureBuilder<Uint8List?>(
                        future: _dbHelper.getImageBytes(photo['image_path']),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Image.memory(
                              snapshot.data!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                      OverflowBar(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await _dbHelper.deletePhoto(photo['id']);
                              _loadPhotos();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Example for BLOB storage (direct in database)
class BlobStorageExample {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> saveUserWithImage() async {
    // Convert image to bytes (from file, network, etc.)
    final File imageFile = File('path/to/image.jpg');
    final Uint8List imageBytes = await imageFile.readAsBytes();

    // Save user with image
    await _dbHelper.insertUser('John Doe', 'john@example.com', imageBytes);
  }

  Future<void> displayUserImage(int userId) async {
    final userData = await _dbHelper.getUserById(userId);
    if (userData != null && userData['profile_image'] != null) {
      final Uint8List imageBytes = userData['profile_image'];
      // Use Image.memory(imageBytes) to display
    }
  }
}
