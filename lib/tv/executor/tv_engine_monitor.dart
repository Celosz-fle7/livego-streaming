class TVEngineMonitor {

  static int executed = 0;

  static int failed = 0;

  static void success() {
    executed++;
  }

  static void error() {
    failed++;
  }
}
