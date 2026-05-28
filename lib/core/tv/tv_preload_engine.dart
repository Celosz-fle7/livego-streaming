class TVPreloadEngine {
  static final List<String>
      preloaded = [];

  static void add(String id) {
    if (!preloaded.contains(id)) {
      preloaded.add(id);
    }
  }

  static bool has(String id) {
    return preloaded.contains(id);
  }

  static void clear() {
    preloaded.clear();
  }
}
