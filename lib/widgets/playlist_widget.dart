import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.songs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.music_note, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text('No songs available'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                  onPressed: () => provider.refreshSongs(),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            provider.refreshSongs();
          },
          child: ListView.builder(
            itemCount: provider.songs.length,
            itemBuilder: (context, index) {
              final song = provider.songs[index];
              final isCurrentSong = index == provider.currentSongIndex;

              return ListTile(
                selected: isCurrentSong,
                selectedTileColor: Colors.blue.withOpacity(0.3),
                leading: Icon(
                  isCurrentSong && provider.isPlaying
                      ? Icons.music_note
                      : Icons.music_note_outlined,
                  color: isCurrentSong ? Colors.blue : null,
                ),
                title: Text(
                  song.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  song.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Download'),
                      onTap: () {
                        provider.downloadSong(song);
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Delete'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Song'),
                            content: const Text(
                              'Are you sure you want to delete this song?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  provider.deleteSong(song.id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                onTap: () {
                  provider.playSong(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}
