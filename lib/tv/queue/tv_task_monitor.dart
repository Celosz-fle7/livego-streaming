class TVTaskMonitor {

  static int completed = 0;

  static int failed = 0;

  static void success() {
    completed++;
  }

  static void error() {
    failed++;
  }
}
