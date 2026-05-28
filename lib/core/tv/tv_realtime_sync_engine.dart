class TVRealtimeSyncEngine {
  static bool active = false;

  static int synced = 0;

  static void start() {
    active = true;
  }

  static void addSync() {
    synced++;
  }

  static void stop() {
    active = false;
  }
}
