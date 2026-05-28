class TVListOptimizer {
  static List<T> limit<T>(
    List<T> items,
    int max,
  ) {
    if (items.length <= max) {
      return items;
    }

    return items.take(max).toList();
  }
}
