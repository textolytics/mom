const express = require('express');
const multer = require('multer');
const cors = require('cors');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Create uploads directory if it doesn't exist
const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
}

// Public directory for downloads
app.use('/uploads', express.static(uploadsDir));

// Multer configuration for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadsDir);
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const name = `${uuidv4()}${ext}`;
    cb(null, name);
  },
});

const fileFilter = (req, file, cb) => {
  const allowedMimes = ['audio/mpeg', 'audio/wav', 'audio/flac', 'audio/mp4'];
  if (allowedMimes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Only audio files are allowed'));
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 100 * 1024 * 1024 }, // 100MB limit
});

// In-memory database (replace with real database for production)
let songs = [];

// Routes

// GET all songs
app.get('/api/songs', (req, res) => {
  try {
    // Scan the uploads directory and get file information
    fs.readdir(uploadsDir, (err, files) => {
      if (err) {
        return res.status(500).json({ error: 'Failed to read songs' });
      }

      const audioFiles = files.filter(file => {
        const ext = path.extname(file).toLowerCase();
        return ['.mp3', '.wav', '.flac', '.m4a'].includes(ext);
      });

      const songList = audioFiles.map(file => {
        const filePath = path.join(uploadsDir, file);
        const stats = fs.statSync(filePath);
        return {
          id: file,
          name: path.basename(file),
          artist: 'Unknown Artist',
          url: `http://localhost:${PORT}/uploads/${file}`,
          duration: 0, // Duration would need to be extracted from audio metadata
          uploadedAt: stats.birthtime || new Date(),
        };
      });

      res.json({ songs: songList });
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET song by ID
app.get('/api/songs/:id', (req, res) => {
  const { id } = req.params;
  const filePath = path.join(uploadsDir, id);

  if (!fs.existsSync(filePath)) {
    return res.status(404).json({ error: 'Song not found' });
  }

  const stats = fs.statSync(filePath);
  const song = {
    id,
    name: path.basename(id),
    artist: 'Unknown Artist',
    url: `http://localhost:${PORT}/uploads/${id}`,
    duration: 0,
    uploadedAt: stats.birthtime || new Date(),
  };

  res.json({ song });
});

// POST upload song
app.post('/api/songs/upload', upload.single('file'), (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file provided' });
    }

    const song = {
      id: req.file.filename,
      name: req.body.name || req.file.originalname,
      artist: req.body.artist || 'Unknown Artist',
      url: `http://localhost:${PORT}/uploads/${req.file.filename}`,
      duration: 0,
      uploadedAt: new Date(),
    };

    res.status(201).json({ song });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// DELETE song
app.delete('/api/songs/:id', (req, res) => {
  try {
    const { id } = req.params;
    const filePath = path.join(uploadsDir, id);

    if (!fs.existsSync(filePath)) {
      return res.status(404).json({ error: 'Song not found' });
    }

    fs.unlinkSync(filePath);
    res.json({ message: 'Song deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'Music server is running' });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({
    error: err.message || 'Internal server error',
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🎵 Music Server running on http://localhost:${PORT}`);
  console.log(`📁 Uploads directory: ${uploadsDir}`);
  console.log(`🌐 Public URL: http://localhost:${PORT}/uploads`);
});
