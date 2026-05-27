class TVSearchHistory {
  static final List<String>
      history = [];

  static void add(String query) {
    history.remove(query);
    history.insert(0, query);

    if (history.length > 20) {
      history.removeLast();
    }
  }

  static void clear() {
    history.clear();
  }
}
