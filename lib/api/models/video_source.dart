class VideoSource {
  final String url;
  final String quality;
  final String type;

  const VideoSource({
    required this.url,
    required this.quality,
    required this.type,
  });

  factory VideoSource.fromJson(Map<String, dynamic> json) {
    return VideoSource(
      url: '${json['url'] ?? ''}',
      quality: '${json['quality'] ?? 'auto'}',
      type: '${json['type'] ?? 'hls'}',
    );
  }
}
