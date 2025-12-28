class Song {
  final String id;
  final String name;
  final String artist;
  final String url;
  final Duration duration;
  final DateTime uploadedAt;

  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.url,
    required this.duration,
    required this.uploadedAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      artist: json['artist'] ?? 'Unknown',
      url: json['url'] ?? '',
      duration: Duration(milliseconds: json['duration'] ?? 0),
      uploadedAt: DateTime.parse(json['uploadedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'url': url,
      'duration': duration.inMilliseconds,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }
}
