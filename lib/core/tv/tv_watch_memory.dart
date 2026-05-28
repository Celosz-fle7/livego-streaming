class TVWatchMemory {
  static final Map<String, dynamic>
      _memory = {};

  static void save({
    required String id,
    required int episode,
    required double seconds,
  }) {
    _memory[id] = {
      'episode': episode,
      'seconds': seconds,
    };
  }

  static Map<String, dynamic>? get(
    String id,
  ) {
    return _memory[id];
  }

  static void clear() {
    _memory.clear();
  }
}
