class TVMemoryCleaner {
  static bool aggressive = false;

  static void enableAggressive() {
    aggressive = true;
  }

  static void disableAggressive() {
    aggressive = false;
  }

  static void clean() {}
}
