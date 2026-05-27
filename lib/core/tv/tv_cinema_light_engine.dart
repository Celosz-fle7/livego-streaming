class TVCinemaLightEngine {
  static bool dimmed = false;

  static int brightness = 100;

  static void dim() {
    dimmed = true;
    brightness = 40;
  }

  static void restore() {
    dimmed = false;
    brightness = 100;
  }
}
