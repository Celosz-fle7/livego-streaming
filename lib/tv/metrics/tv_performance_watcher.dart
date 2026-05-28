class TVPerformanceWatcher {

  static bool lowFps = false;

  static bool highMemory = false;

  static void inspect({
    required int fps,
    required int memory,
  }) {

    lowFps = fps < 24;

    highMemory = memory > 3500;
  }
}
