class TVLiveBoostEngine {
  static bool enabled = false;

  static int latency = 1;

  static void enable() {
    enabled = true;
    latency = 0;
  }
}
