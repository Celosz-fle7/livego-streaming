class TVFrameBudget {
  static int targetFps = 60;
  static int frameMs = 16;

  static void lowEnd() {
    targetFps = 30;
    frameMs = 33;
  }

  static void highEnd() {
    targetFps = 60;
    frameMs = 16;
  }
}
