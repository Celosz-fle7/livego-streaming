class TVRailMemory {
  static final Map<String, int>
      _memory = {};

  static void save(
    String section,
    int index,
  ) {
    _memory[section] = index;
  }

  static int get(String section) {
    return _memory[section] ?? 0;
  }

  static void clear() {
    _memory.clear();
  }
}
