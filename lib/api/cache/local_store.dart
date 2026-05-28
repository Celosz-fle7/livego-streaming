class LocalStore {

  static final Map<String, dynamic>
      _db = {};

  static Future<void> set(
    String key,
    dynamic value,
  ) async {

    _db[key] = value;
  }

  static Future<dynamic> get(
    String key,
  ) async {

    return _db[key];
  }

  static Future<void> remove(
    String key,
  ) async {

    _db.remove(key);
  }

  static Future<void> clear() async {

    _db.clear();
  }
}
