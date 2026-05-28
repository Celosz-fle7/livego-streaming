class TVSmartFPSEngine {
  static int current = 60;

  static bool adaptive = true;

  static void update(
    int fps,
  ) {
    current = fps;
  }
}
