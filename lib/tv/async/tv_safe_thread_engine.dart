class TVSafeThreadEngine {

  static bool active = false;

  static Future<void> start(
    Future<void> Function()
        callback,
  ) async {

    if (active) return;

    active = true;

    try {

      await callback();

    } catch (_) {

    } finally {

      active = false;
    }
  }
}
