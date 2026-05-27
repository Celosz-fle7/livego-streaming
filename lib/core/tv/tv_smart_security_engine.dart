class TVSmartSecurityEngine {
  static bool vpn = false;

  static bool encrypted = true;

  static void enableVPN() {
    vpn = true;
  }

  static void disableVPN() {
    vpn = false;
  }
}
