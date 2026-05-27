class TVGlobalStore {

  static final Map<String, dynamic>
      _store = {};

  static void set(
    String key,
    dynamic value,
  ) {

    _store[key] = value;
  }

  static dynamic get(
    String key,
  ) {

    return _store[key];
  }

  static bool has(
    String key,
  ) {

    return _store.containsKey(
      key,
    );
  }

  static void remove(
    String key,
  ) {

    _store.remove(key);
  }

  static void clear() {

    _store.clear();
  }
}
