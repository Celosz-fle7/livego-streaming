class TVSafeFutureWrapper {

  static Future<void> wrap(
    Future<void> Function()
        callback,
  ) async {

    try {

      await callback();

    } catch (_) {}
  }
}
