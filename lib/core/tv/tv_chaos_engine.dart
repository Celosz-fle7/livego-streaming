class TVChaosEngine {
  static bool unstable = false;

  static int storms = 0;

  static void trigger() {
    unstable = true;
    storms++;
  }
}
