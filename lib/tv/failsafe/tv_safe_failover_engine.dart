class TVSafeFailoverEngine {

  static bool fallback =
      false;

  static void enable() {

    fallback = true;
  }

  static void disable() {

    fallback = false;
  }
}
