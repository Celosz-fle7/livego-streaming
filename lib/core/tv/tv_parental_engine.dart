class TVParentalEngine {
  static bool enabled = false;

  static String pin = '1234';

  static void enable() {
    enabled = true;
  }

  static void disable() {
    enabled = false;
  }

  static bool verify(String value) {
    return value == pin;
  }
}
