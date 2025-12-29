# Music Player - Complete Setup Guide

A multi-platform music player application with web support, local server storage, and public file sharing.

## 📋 Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                     Flutter App                          │
│  (Android, iOS, macOS, Linux, Windows, Web)             │
│  ┌──────────────────────────────────────────────────┐   │
│  │         Music Player Header                       │   │
│  │  - Play/Pause/Next/Previous                       │   │
│  │  - Progress slider                                │   │
│  │  - Current song info                              │   │
│  ├──────────────────────────────────────────────────┤   │
│  │  Playlist View          │        Upload Widget    │   │
│  │  - List all songs       │    - Select audio file  │   │
│  │  - Play/Download        │    - Enter artist name  │   │
│  │  - Delete                │    - Upload to server   │   │
│  └──────────────────────────────────────────────────┘   │
│              ↓ HTTP/REST API ↓                           │
└─────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│            Node.js Express Server                         │
│  (localhost:3000)                                         │
│  ┌─────────────────────────────────────────────────────┐ │
│  │ GET    /api/songs          - List all songs         │ │
│  │ GET    /api/songs/:id      - Get song details      │ │
│  │ POST   /api/songs/upload   - Upload new song       │ │
│  │ DELETE /api/songs/:id      - Delete song           │ │
│  │ GET    /uploads/:filename  - Stream/download song  │ │
│  │ GET    /api/health         - Health check          │ │
│  └─────────────────────────────────────────────────────┘ │
│              ↓                                             │
│        uploads/ directory                                │
│        (Publicly accessible files)                       │
└──────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.10.4+
- Node.js 16+
- npm or yarn
- A code editor (VS Code recommended)

### 1. Install Flutter Dependencies

```bash
flutter pub get
```

### 2. Install Server Dependencies

```bash
cd server
npm install
```

### 3. Start the Backend Server

```bash
cd server
npm run dev
# or for production:
npm start
```

Server will be available at: `http://localhost:3000`

### 4. Run the Flutter App

In a new terminal:

```bash
cd ..

# For Android
flutter run

# For iOS (macOS only)
flutter run -d ios

# For Web
flutter run -d chrome

# For macOS
flutter run -d macos

# For Linux
flutter run -d linux

# For Windows
flutter run -d windows
```

## 📁 Project Structure

```
mom/
├── lib/                          # Flutter app source
│   ├── main.dart                # App entry point
│   ├── screens/
│   │   └── music_player_screen.dart
│   ├── widgets/
│   │   ├── music_player_header.dart
│   │   ├── playlist_widget.dart
│   │   └── upload_widget.dart
│   ├── providers/
│   │   └── music_provider.dart   # State management
│   ├── models/
│   │   └── song_model.dart
│   └── services/
│       └── api_service.dart      # API client
├── server/                       # Node.js backend
│   ├── server.js                # Main server
│   ├── package.json
│   ├── .env
│   ├── uploads/                 # Public audio files
│   └── README.md
├── pubspec.yaml                 # Flutter dependencies
└── README.md
```

## 🎵 Features

### Music Player
- ▶️ Play, pause, skip forward/backward
- 📊 Progress slider with duration display
- 🎵 Current song title and artist display
- 🔄 Auto-loop when reaching end of playlist

### File Management
- 📤 Upload audio files (MP3, WAV, FLAC, M4A)
- 📥 Download songs to device
- 🗑️ Delete songs from server
- 🌐 Public access to all uploaded files

### Multi-Platform Support
- 📱 Android (requires Android SDK)
- 🍎 iOS (requires Xcode, macOS only)
- 💻 macOS
- 🐧 Linux
- 🪟 Windows
- 🌐 Web (Chrome, Firefox, Safari)

## 🔌 API Reference

### Get All Songs
```bash
curl http://localhost:3000/api/songs
```

Response:
```json
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
curl -X POST http://localhost:3000/api/songs/upload \
  -F "file=@/path/to/song.mp3" \
  -F "name=Song Name" \
  -F "artist=Artist Name"
```

### Download Song
```bash
curl http://localhost:3000/uploads/uuid-filename.mp3 -o song.mp3
```

### Delete Song
```bash
curl -X DELETE http://localhost:3000/api/songs/uuid-filename.mp3
```

## 🛠️ Configuration

### Change Server Port

Edit `server/.env`:
```
PORT=3000
```

### Adjust Maximum File Size

In `server/server.js`:
```javascript
limits: { fileSize: 100 * 1024 * 1024 }, // Change to desired size
```

### Update API Base URL for Flutter

In `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://localhost:3000/api';
// Change 'localhost' to server IP for remote connections
```

For testing on different devices:
```dart
// Use your machine's IP address instead of localhost
static const String baseUrl = 'http://192.168.x.x:3000/api';
```

## 🔐 Public Access

All uploaded files are automatically publicly accessible:

```
http://localhost:3000/uploads/filename.mp3
```

For remote access, replace `localhost` with your server's IP address or domain:

```
http://192.168.x.x:3000/uploads/filename.mp3
http://yourdomain.com:3000/uploads/filename.mp3
```

## 📱 Building for Production

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS App
```bash
flutter build ios --release
# Output: build/ios/ipa/
```

### Web Build
```bash
flutter build web --release
# Output: build/web/
# Deploy to any static hosting (Vercel, Netlify, etc.)
```

### macOS App
```bash
flutter build macos --release
# Output: build/macos/Build/Products/Release/
```

### Linux
```bash
flutter build linux --release
# Output: build/linux/x64/release/bundle/
```

### Windows
```bash
flutter build windows --release
# Output: build/windows/runner/Release/
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Server Health Check
```bash
curl http://localhost:3000/api/health
```

### Test Upload
```bash
curl -X POST http://localhost:3000/api/songs/upload \
  -F "file=@test_song.mp3" \
  -F "name=Test Song" \
  -F "artist=Test Artist"
```

## 🐛 Troubleshooting

### Server Not Connecting

1. Ensure server is running:
```bash
npm run dev
```

2. Check if port 3000 is available:
```bash
lsof -i :3000
```

3. Update API base URL in `lib/services/api_service.dart` if server is on different machine:
```dart
// Instead of localhost, use your server IP
static const String baseUrl = 'http://192.168.1.100:3000/api';
```

### Audio Files Not Playing

1. Check supported formats: MP3, WAV, FLAC, M4A
2. Ensure file upload was successful
3. Check browser console for CORS errors (web)
4. Verify file URL is accessible: `http://localhost:3000/uploads/filename.mp3`

### Upload Fails

1. Check file size (max 100MB)
2. Verify file format is audio
3. Ensure uploads directory exists and is writable
4. Check server logs for detailed error messages

### Permission Errors

On Linux/macOS:
```bash
chmod -R 755 server/uploads
```

## 📊 Monitoring Server

View logs:
```bash
# Development mode with nodemon
npm run dev
```

Check server status:
```bash
curl http://localhost:3000/api/health
```

List all uploaded files:
```bash
ls -lah server/uploads/
```

## 🔄 Hot Reload

### Flutter
During development, use hot reload:
- Press `r` in terminal for hot reload
- Press `R` for hot restart

### Server
Nodemon automatically restarts on file changes during `npm run dev`

## 📚 Dependencies

### Flutter
- `just_audio` - Audio playback
- `audio_service` - Background audio
- `provider` - State management
- `dio` - HTTP client
- `file_picker` - File selection
- `path_provider` - App directories

### Node.js
- `express` - Web framework
- `multer` - File uploads
- `cors` - Cross-origin requests
- `uuid` - Unique IDs
- `dotenv` - Environment variables

## 🚢 Deployment

### Local Network Testing

1. Find your machine's IP:
```bash
ifconfig | grep "inet "
```

2. Update API URL in app to use your IP
3. Other devices on same network can access via `http://YOUR_IP:3000`

### Cloud Deployment

#### Deploy Server

1. Use services like Heroku, AWS, Digital Ocean, etc.
2. Set `PORT` environment variable
3. Update `API_SERVICE` base URL in Flutter app

#### Deploy Flutter Web

```bash
flutter build web --release
# Upload build/web/ to hosting (Netlify, Vercel, Firebase, etc.)
```

## 🎓 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Express.js Guide](https://expressjs.com/)
- [Multer Documentation](https://github.com/expressjs/multer)
- [just_audio Package](https://pub.dev/packages/just_audio)

## 📝 License

MIT License

## ❓ Support

For issues or questions:
1. Check logs in server terminal
2. Check Flutter console output
3. Verify network connectivity
4. Check file permissions
5. Ensure all dependencies are installed

---

**Ready to play music!** 🎶
