class TVSessionCache {
  static final Map<String, dynamic>
      _cache = {};

  static dynamic get(String key) {
    return _cache[key];
  }

  static void set(
    String key,
    dynamic value,
  ) {
    _cache[key] = value;
  }

  static void clear() {
    _cache.clear();
  }
}
