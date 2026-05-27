class TVUpdateEngine {
  static bool available = false;

  static String latest =
      '2.0.0';

  static void setUpdate(
    String version,
  ) {
    available = true;
    latest = version;
  }

  static void clear() {
    available = false;
  }
}
