import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/music_provider.dart';
import '../widgets/music_player_header.dart';
import '../widgets/playlist_widget.dart';
import '../widgets/upload_widget.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Initial load of songs
    Future.microtask(() {
      context.read<MusicProvider>().refreshSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Music Player Header
          const MusicPlayerHeader(),
          // Tab Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: SegmentedButton<int>(
                    segments: const <ButtonSegment<int>>[
                      ButtonSegment<int>(
                        value: 0,
                        label: Text('Playlist'),
                      ),
                      ButtonSegment<int>(
                        value: 1,
                        label: Text('Upload'),
                      ),
                    ],
                    selected: <int>{_selectedTab},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        _selectedTab = newSelection.first;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: _selectedTab == 0
                ? const PlaylistWidget()
                : const UploadWidget(),
          ),
        ],
      ),
    );
  }
}
