class TVChronoEngine {
  static bool warped = false;

  static int timelines = 1;

  static void warp() {
    warped = true;
    timelines++;
  }
}
