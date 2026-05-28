class TVSafeServiceWrapper {

  static Future<T?> safe<T>(
    Future<T> Function()
        callback,
  ) async {

    try {

      return await callback();

    } catch (_) {

      return null;
    }
  }
}
