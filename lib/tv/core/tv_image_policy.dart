import 'tv_auto_quality_scaler.dart';

class TVImagePolicy {
  static int cacheWidth = 360;
  static int cacheHeight = 540;
  static bool fadeIn = false;

  static void apply() {
    if (TVAutoQualityScaler.imageQuality == 'LOW') {
      cacheWidth = 220;
      cacheHeight = 330;
      fadeIn = false;
      return;
    }

    cacheWidth = 360;
    cacheHeight = 540;
    fadeIn = true;
  }
}
