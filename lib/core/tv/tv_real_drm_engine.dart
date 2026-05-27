class TVRealDRMEngine {
  static bool enabled = false;

  static String provider = 'widevine';

  static void enable() {
    enabled = true;
  }

  static void disable() {
    enabled = false;
  }
}
