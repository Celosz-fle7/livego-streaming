class ContentDetail {
  final String id;
  final String title;
  final String poster;
  final String description;
  final List<String> genres;

  const ContentDetail({
    required this.id,
    required this.title,
    required this.poster,
    required this.description,
    required this.genres,
  });

  factory ContentDetail.fromJson(Map<String, dynamic> json) {
    return ContentDetail(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? ''}',
      poster: '${json['poster'] ?? ''}',
      description: '${json['description'] ?? ''}',
      genres: (json['genres'] is List)
          ? List<String>.from(json['genres'])
          : <String>[],
    );
  }
}
