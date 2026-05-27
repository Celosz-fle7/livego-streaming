class TVSmartHistoryEngine {
  static final List<String>
      items = [];

  static void add(
    String item,
  ) {
    items.insert(0, item);

    if (items.length > 100) {
      items.removeLast();
    }
  }
}
