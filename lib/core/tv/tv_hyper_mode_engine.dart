class TVHyperModeEngine {
  static bool enabled = false;

  static int boost = 0;

  static void enable() {
    enabled = true;
    boost = 100;
  }

  static void disable() {
    enabled = false;
    boost = 0;
  }
}
