class TVSafeStateCache {

  static final Map<String, dynamic>
      cache = {};

  static void write(
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

  static bool contains(
    String key,
  ) {

    return cache.containsKey(key);
  }

  static void clear() {

    cache.clear();
  }
}
