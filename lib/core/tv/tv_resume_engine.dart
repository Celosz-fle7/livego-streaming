class TVResumeEngine {
  static final Map<String, Duration>
      positions = {};

  static void save(
    String id,
    Duration position,
  ) {
    positions[id] = position;
  }

  static Duration get(String id) {
    return positions[id] ??
        Duration.zero;
  }
}
