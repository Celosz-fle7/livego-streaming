class TVLiveStatusEngine {
  static bool live = false;

  static int viewers = 0;

  static void start(int count) {
    live = true;
    viewers = count;
  }

  static void stop() {
    live = false;
    viewers = 0;
  }
}
