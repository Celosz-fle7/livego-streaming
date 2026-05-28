class WatchHistoryItem {
  final String id;
  final String title;
  final String poster;
  final int position;
  final int duration;

  const WatchHistoryItem({
    required this.id,
    required this.title,
    required this.poster,
    required this.position,
    required this.duration,
  });

  double get progress {
    if (duration <= 0) {
      return 0;
    }

    return position / duration;
  }

  factory WatchHistoryItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return WatchHistoryItem(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? ''}',
      poster: '${json['poster'] ?? ''}',
      position: json['position'] ?? 0,
      duration: json['duration'] ?? 0,
    );
  }
}
