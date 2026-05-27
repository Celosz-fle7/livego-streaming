class TVUserStats {
  static int watchMinutes = 0;

  static int completedSeries = 0;

  static void addMinutes(
    int value,
  ) {
    watchMinutes += value;
  }

  static void completeSeries() {
    completedSeries++;
  }
}
