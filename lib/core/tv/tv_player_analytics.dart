class TVPlayerAnalytics {
  static int totalWatchSeconds = 0;

  static int totalEpisodes = 0;

  static void watch(int seconds) {
    totalWatchSeconds += seconds;
  }

  static void episode() {
    totalEpisodes++;
  }

  static void reset() {
    totalWatchSeconds = 0;
    totalEpisodes = 0;
  }
}
