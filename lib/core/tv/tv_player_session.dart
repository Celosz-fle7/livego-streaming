class TVPlayerSession {
  static String currentDrama = '';

  static int currentEpisode = 1;

  static bool active = false;

  static void start({
    required String drama,
    required int episode,
  }) {
    currentDrama = drama;
    currentEpisode = episode;
    active = true;
  }

  static void stop() {
    active = false;
  }
}
