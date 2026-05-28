class TVSafeCacheEngine {

  static final Map<String, dynamic>
      cache = {};

  static void put(
    String key,
    dynamic value,
  ) {

    cache[key] = value;
  }

  static dynamic read(
    String key,
  ) {

    return cache[key];
  }

  static void wipe() {

    cache.clear();
  }
}
