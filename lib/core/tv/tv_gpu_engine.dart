class TVGPUEngine {
  static bool hardwareAcceleration =
      true;

  static bool hdrEnabled = false;

  static void enableHDR() {
    hdrEnabled = true;
  }

  static void disableHDR() {
    hdrEnabled = false;
  }
}
