class TVMarathonEngine {
  static bool active = false;

  static int episodes = 0;

  static void start() {
    active = true;
    episodes = 0;
  }

  static void nextEpisode() {
    episodes++;
  }

  static void stop() {
    active = false;
  }
}
