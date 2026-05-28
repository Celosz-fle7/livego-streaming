class TVMemoryGuard {

  static int maxCache = 100;

  static bool aggressive =
      false;

  static void enableAggressive() {
    aggressive = true;
    maxCache = 30;
  }

  static void disableAggressive() {
    aggressive = false;
    maxCache = 100;
  }
}
