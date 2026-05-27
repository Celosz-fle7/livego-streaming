class TVUIEngine {
  static bool animations = true;

  static bool blurEffects = true;

  static bool shadows = true;

  static void lowMode() {
    animations = false;
    blurEffects = false;
    shadows = false;
  }
}
