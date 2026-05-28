class ApiCacheTTL {
  static final Map<String, DateTime> _timestamps = {};

  static int ttlMinutes = 30;

  static void mark(String key) {
    _timestamps[key] = DateTime.now();
  }

  static bool expired(String key) {
    final time = _timestamps[key];

    if (time == null) {
      return true;
    }

    return DateTime.now().difference(time).inMinutes >= ttlMinutes;
  }

  static void clear() {
    _timestamps.clear();
  }
}
