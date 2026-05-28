class TVCrashGuard {
  static int crashes = 0;

  static void addCrash() {
    crashes++;
  }

  static bool get unstable =>
      crashes >= 3;

  static void reset() {
    crashes = 0;
  }
}
