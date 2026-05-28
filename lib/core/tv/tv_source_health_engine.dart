class TVSourceHealthEngine {
  static final Map<String, int>
      health = {};

  static void update(
    String source,
    int score,
  ) {
    health[source] = score;
  }

  static int get(String source) {
    return health[source] ?? 0;
  }
}
