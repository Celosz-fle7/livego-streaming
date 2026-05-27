class TVResumeEngine {
  static final Map<String, Map<String, dynamic>>
      _resume = {};

  static void save({
    required String id,
    required int episode,
    required double seconds,
  }) {
    _resume[id] = {
      'episode': episode,
      'seconds': seconds,
    };
  }

  static Map<String, dynamic>? get(
    String id,
  ) {
    return _resume[id];
  }

  static void clear() {
    _resume.clear();
  }
}
