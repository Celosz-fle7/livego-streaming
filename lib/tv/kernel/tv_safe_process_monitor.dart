class TVSafeProcessMonitor {

  static int activeProcesses =
      0;

  static void start() {

    activeProcesses++;
  }

  static void stop() {

    if (activeProcesses > 0) {
      activeProcesses--;
    }
  }
}
