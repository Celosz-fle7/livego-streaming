class TVSafeAPICache {

  static final Map<String, dynamic>
      cache = {};

  static void store(
    String key,
    dynamic value,
  ) {

    cache[key] = value;
  }

  static dynamic fetch(
    String key,
  ) {

    return cache[key];
  }

  static void clear() {

    cache.clear();
  }
}
