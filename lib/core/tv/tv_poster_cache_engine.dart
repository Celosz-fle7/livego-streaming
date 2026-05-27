class TVPosterCacheEngine {
  static final Map<String, String>
      cache = {};

  static void save(
    String id,
    String url,
  ) {
    cache[id] = url;
  }

  static String? get(String id) {
    return cache[id];
  }

  static void clear() {
    cache.clear();
  }
}
