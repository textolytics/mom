# Development Configuration

## Server Configuration

### Port
- Development: 3000
- Testing: 3001
- Production: Use environment variable

### Upload Limits
- Max file size: 100MB
- Allowed formats: MP3, WAV, FLAC, M4A

### CORS
- All origins allowed in development
- Restrict in production

## Flutter Configuration

### API Settings
- Base URL: http://localhost:3000/api
- Timeout: 30 seconds
- Connect Timeout: 30 seconds

### Audio Player
- Buffer Duration: Default
- Supported Formats: MP3, WAV, FLAC, M4A

## Testing Devices

### Available Commands
```bash
# List devices
flutter devices

# Run on specific device
flutter run -d device_id

# Run on chrome
flutter run -d chrome
```

## Environment Variables

### Server (.env)
```
PORT=3000
NODE_ENV=development
```

### Flutter
- API_URL: Configure in `lib/services/api_service.dart`

## Hot Reload

Press `r` in terminal during `flutter run` for hot reload
Press `R` for hot restart

## Debugging

### Server
```bash
# With debug logs
npm run dev
```

### Flutter
```bash
# With verbose logs
flutter run -v
```

## Performance Optimization

### Server
- Enable gzip compression in production
- Implement caching headers
- Use database instead of file system for metadata

### Flutter
- Implement song caching
- Use pagination for large playlists
- Lazy load images

## Security (Production)

- Enable authentication
- Validate file uploads
- Implement rate limiting
- Use HTTPS
- Sanitize file names
- Add file type validation
