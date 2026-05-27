class TVLatencyEngine {
  static int latency = 12;

  static void update(int ms) {
    latency = ms;
  }

  static bool get good =>
      latency <= 40;

  static bool get medium =>
      latency > 40 && latency <= 90;

  static bool get bad =>
      latency > 90;
}
