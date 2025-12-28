# Music Player Server

Node.js backend for the Flutter Music Player application.

## Installation

```bash
npm install
```

## Running the Server

Development:
```bash
npm run dev
```

Production:
```bash
npm start
```

The server will run on `http://localhost:3000` by default.

## API Endpoints

### Get All Songs
```
GET /api/songs
```

### Get Song by ID
```
GET /api/songs/:id
```

### Upload Song
```
POST /api/songs/upload
Content-Type: multipart/form-data

Parameters:
- file: audio file (mp3, wav, flac, m4a)
- name: song name
- artist: artist name
```

### Download Song
```
GET /uploads/:filename
```

### Delete Song
```
DELETE /api/songs/:id
```

### Health Check
```
GET /api/health
```

## Public Access

All uploaded files are publicly accessible at:
```
http://localhost:3000/uploads/filename.mp3
```

## Supported Audio Formats

- MP3 (.mp3)
- WAV (.wav)
- FLAC (.flac)
- M4A (.m4a)

## File Size Limit

Maximum upload size: 100MB

## Directory Structure

```
server/
├── server.js          # Main server file
├── package.json       # Dependencies
├── .env              # Environment variables
├── .gitignore        # Git ignore file
├── uploads/          # Music files (auto-created)
└── README.md         # This file
```
