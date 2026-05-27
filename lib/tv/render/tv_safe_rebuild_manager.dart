class TVSafeRebuildManager {

  static bool locked = false;

  static Future<void>
      rebuild(
    Future<void> Function()
        callback,
  ) async {

    if (locked) return;

    locked = true;

    try {

      await callback();

    } catch (_) {

    } finally {

      locked = false;
    }
  }
}
