class TVEpisodeMemory {
  static final Map<String, int>
      _memory = {};

  static void save(
    String dramaId,
    int episode,
  ) {
    _memory[dramaId] = episode;
  }

  static int get(String dramaId) {
    return _memory[dramaId] ?? 1;
  }

  static void clear() {
    _memory.clear();
  }
}
