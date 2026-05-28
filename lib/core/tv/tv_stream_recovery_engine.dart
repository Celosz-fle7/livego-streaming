class TVStreamRecoveryEngine {
  static bool enabled = true;

  static int retries = 0;

  static void retry() {
    retries++;
  }

  static void reset() {
    retries = 0;
  }
}
