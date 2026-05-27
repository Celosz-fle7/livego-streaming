class TVContinueEngine {
  static final Map<String, double>
      progress = {};

  static void save(
    String id,
    double value,
  ) {
    progress[id] = value;
  }

  static double get(String id) {
    return progress[id] ?? 0;
  }
}
