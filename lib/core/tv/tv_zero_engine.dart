class TVZeroEngine {
  static bool reset = false;

  static int resets = 0;

  static void reboot() {
    reset = true;
    resets++;
  }
}
