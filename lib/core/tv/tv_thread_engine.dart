class TVThreadEngine {
  static int activeThreads = 1;

  static void increase() {
    activeThreads++;
  }

  static void decrease() {
    if (activeThreads > 1) {
      activeThreads--;
    }
  }
}
