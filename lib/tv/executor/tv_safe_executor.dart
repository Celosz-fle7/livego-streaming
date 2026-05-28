class TVSafeExecutor {

  static Future<void> safe(
    Future<void> Function()
        callback,
  ) async {

    try {

      await callback();

    } catch (_) {}
  }
}
