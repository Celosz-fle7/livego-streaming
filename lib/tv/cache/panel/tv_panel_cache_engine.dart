class TVPanelCacheEngine {

  static final Map<String, dynamic>
      cache = {};

  static void save(
    String key,
    dynamic value,
  ) {

    cache[key] = value;
  }

  static dynamic load(
    String key,
  ) {

    return cache[key];
  }

  static void clear() {

    cache.clear();
  }
}
