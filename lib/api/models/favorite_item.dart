class FavoriteItem {
  final String id;
  final String title;
  final String poster;
  final String type;

  const FavoriteItem({
    required this.id,
    required this.title,
    required this.poster,
    required this.type,
  });

  factory FavoriteItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return FavoriteItem(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? ''}',
      poster: '${json['poster'] ?? ''}',
      type: '${json['type'] ?? 'movie'}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster': poster,
      'type': type,
    };
  }
}
