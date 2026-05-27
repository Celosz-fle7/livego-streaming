class ApiSecureMode {
  static bool enabled = true;
  static bool allowMockAuth = true;

  static void production() {
    enabled = true;
    allowMockAuth = false;
  }

  static void development() {
    enabled = true;
    allowMockAuth = true;
  }
}
