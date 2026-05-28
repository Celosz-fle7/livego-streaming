import 'tv_low_memory_mode.dart';

class TVAutoQualityScaler {
  static String uiQuality = 'LOW';
  static String imageQuality = 'MEDIUM';
  static bool animations = false;
  static bool shadows = false;
  static bool blur = false;

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      uiQuality = 'LOW';
      imageQuality = 'LOW';
      animations = false;
      shadows = false;
      blur = false;
      return;
    }

    uiQuality = 'HIGH';
    imageQuality = 'HIGH';
    animations = true;
    shadows = true;
    blur = true;
  }
}
