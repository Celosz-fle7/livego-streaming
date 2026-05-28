class TVWatchTimerEngine {
  static int minutes = 0;

  static void addMinutes(
    int value,
  ) {
    minutes += value;
  }

  static void reset() {
    minutes = 0;
  }
}
