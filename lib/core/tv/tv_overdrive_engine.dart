class TVOverdriveEngine {
  static bool maxed = false;

  static int speed = 100;

  static void engage() {
    maxed = true;
    speed = 999;
  }
}
