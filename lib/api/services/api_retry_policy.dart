class ApiRetryPolicy {
  static int maxRetries = 2;
  static int delayMs = 800;

  static void lowEnd() {
    maxRetries = 1;
    delayMs = 1200;
  }

  static void normal() {
    maxRetries = 2;
    delayMs = 800;
  }
}
