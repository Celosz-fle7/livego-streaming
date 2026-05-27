class TVScreenshotEngine {
  static int total = 0;

  static void capture() {
    total++;
  }

  static void reset() {
    total = 0;
  }
}
