class TVWatchProgress {
  static final Map<String, double>
      _progress = {};

  static void save(
    String id,
    double progress,
  ) {
    _progress[id] = progress;
  }

  static double get(String id) {
    return _progress[id] ?? 0.0;
  }
}
