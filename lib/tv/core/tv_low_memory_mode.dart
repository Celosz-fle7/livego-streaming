class TVLowMemoryMode {

  static bool enabled = true;

  static int maxPanels = 8;

  static int maxLogs = 20;

  static bool realtimeEffects =
      false;

  static void enable() {

    enabled = true;

    maxPanels = 6;
    maxLogs = 15;

    realtimeEffects = false;
  }

  static void disable() {

    enabled = false;

    maxPanels = 20;
    maxLogs = 50;

    realtimeEffects = true;
  }
}
