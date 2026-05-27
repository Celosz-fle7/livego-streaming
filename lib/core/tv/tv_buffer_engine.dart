class TVBufferEngine {
  static int bufferMs = 1200;

  static bool buffering = false;

  static void start() {
    buffering = true;
  }

  static void stop() {
    buffering = false;
  }
}
