import 'tv_low_memory_mode.dart';

class TVPlayerPolicy {
  static String defaultQuality = '480P';
  static int maxBitrate = 1200;
  static bool preloadNext = false;
  static bool animatedControls = false;
  static bool debugOverlay = false;

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      defaultQuality = '480P';
      maxBitrate = 1200;
      preloadNext = false;
      animatedControls = false;
      debugOverlay = false;
      return;
    }

    defaultQuality = '1080P';
    maxBitrate = 4500;
    preloadNext = true;
    animatedControls = true;
    debugOverlay = true;
  }
}
