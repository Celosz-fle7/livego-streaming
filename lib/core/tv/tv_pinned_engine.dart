class TVPinnedEngine {
  static final List<String>
      pinned = [];

  static void add(String id) {
    if (!pinned.contains(id)) {
      pinned.add(id);
    }
  }

  static void remove(String id) {
    pinned.remove(id);
  }

  static bool has(String id) {
    return pinned.contains(id);
  }
}
