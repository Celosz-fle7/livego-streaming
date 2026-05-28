import 'tv_low_memory_mode.dart';

class TVStartupSpeedPolicy {
  static bool preloadHome = false;
  static bool preloadImages = false;
  static bool preloadSystem = true;
  static int bootDelayMs = 150;

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      preloadHome = false;
      preloadImages = false;
      preloadSystem = true;
      bootDelayMs = 100;
      return;
    }

    preloadHome = true;
    preloadImages = true;
    preloadSystem = true;
    bootDelayMs = 300;
  }
}
