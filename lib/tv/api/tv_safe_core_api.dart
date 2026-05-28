class TVSafeCoreAPI {

  static Future<T?> execute<T>(
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
