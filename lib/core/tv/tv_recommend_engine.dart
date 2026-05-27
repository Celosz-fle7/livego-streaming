class TVRecommendEngine {
  static final List<String>
      recommends = [];

  static void setItems(
    List<String> items,
  ) {
    recommends
      ..clear()
      ..addAll(items);
  }
}
