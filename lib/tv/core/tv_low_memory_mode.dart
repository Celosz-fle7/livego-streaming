class TVLowMemoryMode {
  static bool enabled = true;

  static int maxPanels = 8;
  static int maxLogs = 20;
  static int refreshSeconds = 8;

  static bool realtimeEffects = false;

  static void enable() {
    enabled = true;
    maxPanels = 6;
    maxLogs = 15;
    refreshSeconds = 10;
    realtimeEffects = false;
  }

  static void balanced() {
    enabled = true;
    maxPanels = 8;
    maxLogs = 20;
    refreshSeconds = 8;
    realtimeEffects = false;
  }

  static void disable() {
    enabled = false;
    maxPanels = 20;
    maxLogs = 50;
    refreshSeconds = 5;
    realtimeEffects = true;
  }
}
