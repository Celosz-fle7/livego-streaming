class TVRuntimeGCPolicy {

  static int cleanupEvery =
      30;

  static bool aggressive =
      true;

  static void lowEnd() {

    cleanupEvery = 15;

    aggressive = true;
  }

  static void balanced() {

    cleanupEvery = 30;

    aggressive = false;
  }
}
