class TVBandwidthEngine {
  static double mbps = 24.5;

  static void update(double value) {
    mbps = value;
  }

  static String get label {
    if (mbps >= 20) {
      return 'FAST';
    }

    if (mbps >= 8) {
      return 'MEDIUM';
    }

    return 'SLOW';
  }
}
