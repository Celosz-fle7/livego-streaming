class TVPlayerCache {
  static final Map<String, dynamic>
      _cache = {};

  static void set(
    String key,
    dynamic value,
  ) {
    _cache[key] = value;
  }

  static dynamic get(String key) {
    return _cache[key];
  }

  static void clear() {
    _cache.clear();
  }
}
