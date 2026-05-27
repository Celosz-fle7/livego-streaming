class TVHistoryEngine {
  static final List<Map<String, dynamic>>
      _items = [];

  static void add(
    Map<String, dynamic> item,
  ) {
    _items.removeWhere(
      (e) => e['id'] == item['id'],
    );

    _items.insert(0, item);
  }

  static List<Map<String, dynamic>>
      get items => _items;
}
