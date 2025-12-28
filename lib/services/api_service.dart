import 'package:dio/dio.dart';
import 'dart:io';
import '../models/song_model.dart';

class ApiService {
  late Dio _dio;
  static const String baseUrl = 'http://localhost:3000/api';

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  // Get all songs
  Future<List<Song>> getSongs() async {
    try {
      final response = await _dio.get('/songs');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['songs'] ?? [];
        return data.map((json) => Song.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception('Failed to load songs');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Upload song
  Future<Song> uploadSong(File file, String artistName) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
        'name': fileName,
        'artist': artistName,
      });

      final response = await _dio.post('/songs/upload', data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Song.fromJson(response.data['song'] as Map<String, dynamic>);
      }
      throw Exception('Upload failed');
    } catch (e) {
      throw Exception('Upload error: $e');
    }
  }

  // Download song
  Future<void> downloadSong(String url, String savePath) async {
    try {
      await _dio.download(url, savePath);
    } catch (e) {
      throw Exception('Download error: $e');
    }
  }

  // Delete song
  Future<void> deleteSong(String songId) async {
    try {
      final response = await _dio.delete('/songs/$songId');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Delete failed');
      }
    } catch (e) {
      throw Exception('Delete error: $e');
    }
  }

  // Get song by ID
  Future<Song> getSongById(String songId) async {
    try {
      final response = await _dio.get('/songs/$songId');
      if (response.statusCode == 200) {
        return Song.fromJson(response.data['song'] as Map<String, dynamic>);
      }
      throw Exception('Failed to fetch song');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
