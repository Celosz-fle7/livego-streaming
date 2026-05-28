class TVSeekMemory {
  static final Map<String, double>
      _memory = {};

  static void save(
    String id,
    double seconds,
  ) {
    _memory[id] = seconds;
  }

  static double get(String id) {
    return _memory[id] ?? 0;
  }

  static void clear() {
    _memory.clear();
  }
}
