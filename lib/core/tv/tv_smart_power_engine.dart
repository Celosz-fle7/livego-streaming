class TVSmartPowerEngine {
  static bool ecoMode = false;

  static int brightness = 100;

  static void enableEco() {
    ecoMode = true;
    brightness = 60;
  }

  static void disableEco() {
    ecoMode = false;
    brightness = 100;
  }
}
