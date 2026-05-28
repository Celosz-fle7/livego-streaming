class TVDailyLimitEngine {
  static int limitMinutes = 0;

  static int watchedMinutes = 0;

  static void setLimit(int value) {
    limitMinutes = value;
  }

  static void addWatch(int value) {
    watchedMinutes += value;
  }

  static bool get exceeded {
    if (limitMinutes <= 0) {
      return false;
    }

    return watchedMinutes >=
        limitMinutes;
  }
}
