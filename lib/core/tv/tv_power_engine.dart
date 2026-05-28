class TVPowerEngine {
  static bool powerSaving = false;

  static void enable() {
    powerSaving = true;
  }

  static void disable() {
    powerSaving = false;
  }
}
