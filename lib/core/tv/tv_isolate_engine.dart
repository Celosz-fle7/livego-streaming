class TVIsolateEngine {
  static bool enabled = true;

  static int workers = 2;

  static void enable() {
    enabled = true;
  }

  static void disable() {
    enabled = false;
  }

  static void setWorkers(int count) {
    workers = count;
  }
}
