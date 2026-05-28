class TVPlayerState {
  static bool playing = false;

  static bool buffering = false;

  static bool controlsVisible = false;

  static int currentEpisode = 1;

  static double progress = 0;

  static void reset() {
    playing = false;
    buffering = false;
    controlsVisible = false;
    currentEpisode = 1;
    progress = 0;
  }
}
