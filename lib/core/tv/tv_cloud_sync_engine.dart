class TVCloudSyncEngine {
  static bool syncing = false;

  static DateTime? lastSync;

  static void sync() {
    syncing = true;
    lastSync = DateTime.now();
  }

  static void complete() {
    syncing = false;
  }
}
