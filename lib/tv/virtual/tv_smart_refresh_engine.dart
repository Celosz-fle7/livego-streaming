class TVSmartRefreshEngine {

  static bool enabled = true;

  static int refreshes = 0;

  static void refresh() {

    if (!enabled) return;

    refreshes++;
  }

  static void pause() {

    enabled = false;
  }

  static void resume() {

    enabled = true;
  }
}
