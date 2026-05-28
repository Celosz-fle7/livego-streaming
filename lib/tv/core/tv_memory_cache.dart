class TVMemoryCache {

  static final Map<String, dynamic>
      cache = {};

  static void set(
    String key,
    dynamic value,
  ) {
    cache[key] = value;
  }

  static dynamic get(
    String key,
  ) {
    return cache[key];
  }

  static void clear() {
    cache.clear();
  }
}
