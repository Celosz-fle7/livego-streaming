class ContentItem {
  final String id;
  final String title;
  final String poster;
  final String type;

  const ContentItem({
    required this.id,
    required this.title,
    required this.poster,
    required this.type,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? ''}',
      poster: '${json['poster'] ?? ''}',
      type: '${json['type'] ?? 'movie'}',
    );
  }
}
