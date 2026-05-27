class TVSafeAsyncEngine {

  static bool busy = false;

  static Future<T?> run<T>(
    Future<T> Function()
        callback,
  ) async {

    if (busy) {
      return null;
    }

    busy = true;

    try {

      return await callback();

    } catch (_) {

      return null;

    } finally {

      busy = false;
    }
  }
}
