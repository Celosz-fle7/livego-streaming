class PaginatedResponse<T> {
  final List<T> items;
  final int page;
  final bool hasMore;

  const PaginatedResponse({
    required this.items,
    required this.page,
    required this.hasMore,
  });
}
