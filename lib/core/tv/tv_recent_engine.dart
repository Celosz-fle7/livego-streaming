class TVRecentEngine {
  static final List<String>
      recent = [];

  static void add(String id) {
    recent.remove(id);
    recent.insert(0, id);

    if (recent.length > 30) {
      recent.removeLast();
    }
  }
}
