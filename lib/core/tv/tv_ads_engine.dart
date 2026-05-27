class TVAdsEngine {
  static bool enabled = false;

  static int intervalMinutes = 15;

  static void enable() {
    enabled = true;
  }

  static void disable() {
    enabled = false;
  }
}
