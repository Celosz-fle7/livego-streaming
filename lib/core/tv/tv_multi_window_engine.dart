class TVMultiWindowEngine {
  static bool enabled = false;

  static int windows = 1;

  static void enable(int total) {
    enabled = true;
    windows = total;
  }

  static void disable() {
    enabled = false;
    windows = 1;
  }
}
