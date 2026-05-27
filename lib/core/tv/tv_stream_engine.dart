class TVStreamEngine {
  static bool adaptiveBitrate = true;

  static String currentQuality =
      'AUTO';

  static void setQuality(
    String quality,
  ) {
    currentQuality = quality;
  }

  static void disableAdaptive() {
    adaptiveBitrate = false;
  }

  static void enableAdaptive() {
    adaptiveBitrate = true;
  }
}
