class TVEpisodeMemory {
  static final Map<String, int>
      episodes = {};

  static void save(
    String id,
    int ep,
  ) {
    episodes[id] = ep;
  }

  static int get(String id) {
    return episodes[id] ?? 1;
  }
}
