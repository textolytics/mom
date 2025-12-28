# 🎵 Music Player

A modern, cross-platform music player application built with Flutter and Node.js. Stream, upload, download, and share music files across web, mobile, and desktop platforms.

## ✨ Features

- **🎵 Universal Music Player**
  - Play/pause, skip forward/backward
  - Progress slider with time display
  - Current song information display
  - Support for MP3, WAV, FLAC, M4A formats

- **📤 File Management**
  - Upload audio files to central server
  - Download songs to your device
  - Delete files from library
  - Public access to all shared files

- **🌐 Multi-Platform Support**
  - 📱 Android
  - 🍎 iOS
  - 💻 macOS
  - 🐧 Linux
  - 🪟 Windows
  - 🌐 Web (Chrome, Firefox, Safari)

- **🔗 Network Features**
  - Real-time server synchronization
  - Public file sharing
  - Direct streaming support
  - RESTful API backend

## 🚀 Quick Start

### Prerequisites

```bash
# Check versions required
flutter --version  # 3.10.4+
node --version     # 16+
npm --version      # 8+
```

### Installation

```bash
# 1. Clone/navigate to project
cd /Users/vasilimitioglo/src/mom

# 2. Run setup script (automatic)
chmod +x setup.sh
./setup.sh

# OR manual setup:

# 2a. Install Flutter dependencies
flutter pub get

# 2b. Install server dependencies
cd server && npm install && cd ..
```

### Running the Application

#### Option 1: Automated Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

#### Option 2: Manual Startup

Terminal 1 - Start Backend Server:
```bash
cd server
npm run dev
# Server runs on http://localhost:3000
```

Terminal 2 - Run Flutter App:
```bash
# Android/iOS
flutter run

# Web
flutter run -d chrome

# macOS
flutter run -d macos

# Linux
flutter run -d linux

# Windows
flutter run -d windows
```

## 📋 Project Structure

```
mom/
├── lib/                              # Flutter application
│   ├── main.dart                    # App entry point
│   ├── screens/
│   │   └── music_player_screen.dart # Main UI screen
│   ├── widgets/
│   │   ├── music_player_header.dart # Player controls
│   │   ├── playlist_widget.dart      # Song list
│   │   └── upload_widget.dart        # Upload interface
│   ├── providers/
│   │   └── music_provider.dart       # State management
│   ├── models/
│   │   └── song_model.dart           # Data model
│   └── services/
│       └── api_service.dart          # API client
├── server/                           # Node.js backend
│   ├── server.js                    # Express server
│   ├── package.json                 # Dependencies
│   ├── .env                         # Config
│   ├── uploads/                     # Public files
│   └── README.md
├── web/                              # Web assets
│── android/                          # Android native code
│── ios/                              # iOS native code
│── macos/                            # macOS native code
│── linux/                            # Linux native code
│── windows/                          # Windows native code
├── pubspec.yaml                      # Flutter dependencies
├── SETUP_GUIDE.md                   # Detailed setup
├── setup.sh                          # Auto setup script
└── README.md                         # This file
```

## 🔌 API Reference

### Get All Songs
```bash
GET http://localhost:3000/api/songs

Response:
{
  "songs": [
    {
      "id": "uuid-filename.mp3",
      "name": "Song Name",
      "artist": "Artist Name",
      "url": "http://localhost:3000/uploads/uuid-filename.mp3",
      "duration": 180000,
      "uploadedAt": "2025-12-28T10:00:00.000Z"
    }
  ]
}
```

### Upload Song
```bash
POST http://localhost:3000/api/songs/upload
Content-Type: multipart/form-data

Parameters:
  - file: audio file (required)
  - name: song name
  - artist: artist name
```

### Download Song
Direct file access:
```
http://localhost:3000/uploads/filename.mp3
```

### Delete Song
```bash
DELETE http://localhost:3000/api/songs/:id
```

### Health Check
```bash
GET http://localhost:3000/api/health
```

## 📱 Platform-Specific Setup

### Android
```bash
# Requirements: Android SDK, min API 21
flutter run
```

### iOS
```bash
# Requirements: Xcode, iOS 11+
# macOS only
flutter run -d ios
```

### Web
```bash
# No additional requirements
flutter run -d chrome
# or firefox, safari
```

### macOS
```bash
# Requirements: Xcode
flutter run -d macos
```

### Linux
```bash
# Requirements: GTK 3.0+
flutter run -d linux
```

### Windows
```bash
# Requirements: Visual Studio Build Tools
flutter run -d windows
```

## 🛠️ Configuration

### Change Server Port

Edit `server/.env`:
```env
PORT=3000
```

### Update API URL for Remote Server

Edit `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://YOUR_SERVER_IP:3000/api';
```

## 🔐 Public Access

All uploaded files are publicly accessible at:
```
http://localhost:3000/uploads/filename.mp3
```

For remote access:
```
http://192.168.x.x:3000/uploads/filename.mp3
```

## 📦 Dependencies

### Flutter
- `just_audio: ^0.9.36` - Audio playback
- `provider: ^6.1.0` - State management
- `dio: ^5.4.0` - HTTP client
- `file_picker: ^6.1.1` - File selection
- `path_provider: ^2.1.2` - App directories

### Server
- `express: ^4.18.2` - Web framework
- `multer: ^1.4.5` - File uploads
- `cors: ^2.8.5` - CORS support
- `uuid: ^9.0.1` - Unique IDs

## 🧪 Testing

### Test API
```bash
curl http://localhost:3000/api/health
```

### Test Upload
```bash
curl -X POST http://localhost:3000/api/songs/upload \
  -F "file=@test.mp3" \
  -F "name=Test Song" \
  -F "artist=Test Artist"
```

### Run Flutter Tests
```bash
flutter test
```

## 🚢 Building for Production

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS App
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
# Deploy build/web/ to hosting service
```

### macOS
```bash
flutter build macos --release
```

### Linux
```bash
flutter build linux --release
```

### Windows
```bash
flutter build windows --release
```

## 🐛 Troubleshooting

### Server Connection Issues
```bash
# Check if server is running
lsof -i :3000

# Check logs
cd server && npm run dev
```

### Flutter Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### File Upload Problems
- Check file format (MP3, WAV, FLAC, M4A)
- Verify file size (max 100MB)
- Ensure server is running
- Check server logs for errors

### Audio Playback Issues
- Verify file format compatibility
- Check file URL is accessible
- Clear app cache and rebuild

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Express.js Guide](https://expressjs.com/)
- [just_audio Package](https://pub.dev/packages/just_audio)

See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed setup instructions.

## 📄 License

MIT License

## 🤝 Support

For issues:
1. Check [SETUP_GUIDE.md](SETUP_GUIDE.md)
2. Review server logs
3. Check Flutter console output
4. Verify network connectivity

---

**Made with 🎶 for music lovers everywhere**
