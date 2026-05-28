class TVBandwidthEngine {
  static double current = 120.0;

  static double peak = 220.0;

  static void update(
    double value,
  ) {
    current = value;

    if (value > peak) {
      peak = value;
    }
  }
}
