class TVHistoryEngine {
  static final List<String>
      recent = [];

  static void add(String id) {
    recent.remove(id);
    recent.insert(0, id);

    if (recent.length > 50) {
      recent.removeLast();
    }
  }

  static void clear() {
    recent.clear();
  }
}
