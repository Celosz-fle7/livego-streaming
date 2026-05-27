import 'tv_low_memory_mode.dart';

class TVHomePolicy {
  static int maxRails = 5;
  static int maxItemsPerRail = 12;
  static bool heroAutoplay = false;
  static bool preloadPosters = false;

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      maxRails = 4;
      maxItemsPerRail = 8;
      heroAutoplay = false;
      preloadPosters = false;
      return;
    }

    maxRails = 8;
    maxItemsPerRail = 20;
    heroAutoplay = true;
    preloadPosters = true;
  }
}
