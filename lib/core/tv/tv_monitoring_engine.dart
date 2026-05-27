class TVMonitoringEngine {
  static bool enabled = true;

  static int activeUsers = 0;

  static int streams = 0;

  static void addUser() {
    activeUsers++;
  }

  static void addStream() {
    streams++;
  }
}
