class TVPerformanceManager {

  static bool lowMemoryMode =
      false;

  static bool lazyLoad =
      true;

  static int maxWidgets = 50;

  static void enableLowMemory() {
    lowMemoryMode = true;
    maxWidgets = 20;
  }

  static void disableLowMemory() {
    lowMemoryMode = false;
    maxWidgets = 50;
  }
}
