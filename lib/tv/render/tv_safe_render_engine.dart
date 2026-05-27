class TVSafeRenderEngine {

  static bool rendering = false;

  static int rendered = 0;

  static Future<void>
      render(
    Future<void> Function()
        callback,
  ) async {

    try {

      rendering = true;

      await callback();

      rendered++;

    } catch (_) {

    } finally {

      rendering = false;
    }
  }
}
