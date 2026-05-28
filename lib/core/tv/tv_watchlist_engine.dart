class TVWatchlistEngine {
  static final List<String>
      items = [];

  static void add(String id) {
    if (!items.contains(id)) {
      items.add(id);
    }
  }

  static void remove(String id) {
    items.remove(id);
  }

  static bool has(String id) {
    return items.contains(id);
  }
}
