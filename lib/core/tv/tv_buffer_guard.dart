class TVBufferGuard {
  static bool buffering = false;

  static void start() {
    buffering = true;
  }

  static void stop() {
    buffering = false;
  }
}
