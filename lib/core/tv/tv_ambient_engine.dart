class TVAmbientEngine {
  static bool enabled = false;

  static int timeout = 5;

  static void enable() {
    enabled = true;
  }

  static void disable() {
    enabled = false;
  }
}
