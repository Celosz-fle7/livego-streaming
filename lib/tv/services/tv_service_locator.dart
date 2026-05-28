class TVServiceLocator {

  static final Map<String, dynamic>
      _services = {};

  static void register(
    String key,
    dynamic service,
  ) {

    _services[key] = service;
  }

  static T? get<T>(
    String key,
  ) {

    return _services[key] as T?;
  }

  static bool has(
    String key,
  ) {

    return _services.containsKey(
      key,
    );
  }

  static void remove(
    String key,
  ) {

    _services.remove(key);
  }

  static void clear() {

    _services.clear();
  }
}
