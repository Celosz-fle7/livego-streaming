class TVSecurityEngine {
  static bool antiDebug = false;

  static bool antiTamper = false;

  static bool secureMode = false;

  static void enableAll() {
    antiDebug = true;
    antiTamper = true;
    secureMode = true;
  }
}
