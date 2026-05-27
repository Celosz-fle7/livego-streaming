class TVAutoRetryEngine {
  static bool enabled = true;

  static int retries = 3;

  static void setRetries(
    int value,
  ) {
    retries = value;
  }
}
