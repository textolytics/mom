import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
// ignore: unused_import
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/song_model.dart';
import '../services/api_service.dart';

class MusicProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  List<Song> _songs = [];
  int _currentSongIndex = 0;
  bool _isPlaying = false;
  bool _isLoading = false;
  String _errorMessage = '';
  double _currentPosition = 0;
  double _duration = 0;
  
  final ApiService _apiService = ApiService();

  MusicProvider() {
    _initializeAudioPlayer();
    _loadSongs();
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.positionStream.listen((position) {
      _currentPosition = position.inMilliseconds.toDouble();
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _duration = duration?.inMilliseconds.toDouble() ?? 0;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  // Getters
  List<Song> get songs => _songs;
  int get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  double get currentPosition => _currentPosition;
  double get duration => _duration;
  Song? get currentSong => _songs.isNotEmpty ? _songs[_currentSongIndex] : null;

  Future<void> _loadSongs() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final songList = await _apiService.getSongs();
      _songs = songList;
      _isLoading = false;
    } catch (e) {
      _errorMessage = 'Failed to load songs: ${e.toString()}';
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> playSong(int index) async {
    if (index < 0 || index >= _songs.length) return;

    _currentSongIndex = index;
    final song = _songs[index];

    try {
      _isLoading = true;
      notifyListeners();

      await _audioPlayer.setUrl(song.url);
      await _audioPlayer.play();
      _isPlaying = true;
      _isLoading = false;
    } catch (e) {
      _errorMessage = 'Failed to play song: ${e.toString()}';
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
      _isPlaying = !_isPlaying;
    } catch (e) {
      _errorMessage = 'Playback error: ${e.toString()}';
    }
    notifyListeners();
  }

  Future<void> nextSong() async {
    if (_currentSongIndex < _songs.length - 1) {
      await playSong(_currentSongIndex + 1);
    } else {
      await playSong(0);
    }
  }

  Future<void> previousSong() async {
    if (_currentSongIndex > 0) {
      await playSong(_currentSongIndex - 1);
    } else {
      await playSong(_songs.length - 1);
    }
  }

  Future<void> seek(double milliseconds) async {
    try {
      await _audioPlayer.seek(Duration(milliseconds: milliseconds.toInt()));
    } catch (e) {
      _errorMessage = 'Seek error: ${e.toString()}';
    }
    notifyListeners();
  }

  Future<void> uploadSong(File file, String name) async {
    try {
      _isLoading = true;
      notifyListeners();

      final song = await _apiService.uploadSong(file, name);
      _songs.add(song);
      _isLoading = false;
      _errorMessage = 'Song uploaded successfully';
    } catch (e) {
      _errorMessage = 'Upload failed: ${e.toString()}';
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> downloadSong(Song song) async {
    try {
      _isLoading = true;
      notifyListeners();

      final appDir = await getApplicationDocumentsDirectory();
      final downloadDir = Directory('${appDir.path}/downloads');
      
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      final file = File('${downloadDir.path}/${song.name}');
      
      await _apiService.downloadSong(song.url, file.path);
      _errorMessage = 'Song downloaded to ${file.path}';
      _isLoading = false;
    } catch (e) {
      _errorMessage = 'Download failed: ${e.toString()}';
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> deleteSong(String songId) async {
    try {
      await _apiService.deleteSong(songId);
      _songs.removeWhere((song) => song.id == songId);
      if (_currentSongIndex >= _songs.length && _songs.isNotEmpty) {
        _currentSongIndex = _songs.length - 1;
      }
      _errorMessage = 'Song deleted';
    } catch (e) {
      _errorMessage = 'Delete failed: ${e.toString()}';
    }
    notifyListeners();
  }

  void refreshSongs() {
    _loadSongs();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
