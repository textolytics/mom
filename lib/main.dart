import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/music_player_screen.dart';
import 'providers/music_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MusicProvider(),
      child: MaterialApp(
        title: 'Music Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const MusicPlayerScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
