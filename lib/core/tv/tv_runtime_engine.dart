class TVRuntimeEngine {
  static bool initialized = false;

  static DateTime? startedAt;

  static void boot() {
    initialized = true;
    startedAt = DateTime.now();
  }

  static int uptimeSeconds() {
    if (startedAt == null) {
      return 0;
    }

    return DateTime.now()
        .difference(startedAt!)
        .inSeconds;
  }
}
