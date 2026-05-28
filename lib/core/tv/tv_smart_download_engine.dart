class TVSmartDownloadEngine {
  static int active = 0;

  static int completed = 0;

  static void start() {
    active++;
  }

  static void finish() {
    active--;
    completed++;
  }
}
