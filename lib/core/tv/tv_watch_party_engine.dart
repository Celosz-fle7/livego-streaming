class TVWatchPartyEngine {
  static bool active = false;

  static int members = 0;

  static void start(int total) {
    active = true;
    members = total;
  }

  static void stop() {
    active = false;
    members = 0;
  }
}
