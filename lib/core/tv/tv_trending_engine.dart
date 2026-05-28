class TVTrendingEngine {
  static final List<String>
      trending = [];

  static void setItems(
    List<String> items,
  ) {
    trending
      ..clear()
      ..addAll(items);
  }
}
