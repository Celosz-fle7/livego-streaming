class ApiTimeoutConfig {
  static int seconds = 15;

  static void lowEnd() {
    seconds = 20;
  }

  static void fast() {
    seconds = 10;
  }
}
