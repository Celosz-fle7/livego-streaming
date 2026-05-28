class TVFrameTracker {

  static int frames = 0;

  static void track() {
    frames++;
  }

  static void reset() {
    frames = 0;
  }
}
