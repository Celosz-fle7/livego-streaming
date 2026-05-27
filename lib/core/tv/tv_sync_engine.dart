class TVSyncEngine {
  static bool syncing = false;

  static int syncedItems = 0;

  static void start() {
    syncing = true;
  }

  static void finish(int total) {
    syncing = false;
    syncedItems = total;
  }
}
