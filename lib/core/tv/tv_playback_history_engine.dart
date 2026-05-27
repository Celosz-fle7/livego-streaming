class TVPlaybackHistoryEngine {
  static final List<String>
      sessions = [];

  static void add(String text) {
    sessions.insert(0, text);

    if (sessions.length > 100) {
      sessions.removeLast();
    }
  }

  static void clear() {
    sessions.clear();
  }
}
