class TVGlobalStore {
  static final Map<String, dynamic> store = {};

  static void set(String key, dynamic value) {
    store[key] = value;
  }

  static dynamic get(String key) {
    return store[key];
  }

  static bool has(String key) {
    return store.containsKey(key);
  }

  static void remove(String key) {
    store.remove(key);
  }

  static void clear() {
    store.clear();
  }
}
