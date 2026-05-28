class TVAutoFPSEngine {
  static bool enabled = true;

  static int current = 60;

  static void update(
    int value,
  ) {
    current = value;
  }
}
