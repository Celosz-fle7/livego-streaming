import 'tv_low_memory_mode.dart';
import 'tv_player_policy.dart';

class TVNetworkAdaptivePolicy {
  static int bandwidthMbps = 10;
  static bool metered = false;
  static String mode = 'BALANCED';

  static void update({
    int? bandwidth,
    bool? isMetered,
  }) {
    if (bandwidth != null) {
      bandwidthMbps = bandwidth;
    }

    if (isMetered != null) {
      metered = isMetered;
    }

    if (metered || bandwidthMbps <= 5 || TVLowMemoryMode.enabled) {
      mode = 'SAVE_DATA';
      TVPlayerPolicy.defaultQuality = '480P';
      TVPlayerPolicy.maxBitrate = 1000;
      TVPlayerPolicy.preloadNext = false;
      return;
    }

    if (bandwidthMbps <= 12) {
      mode = 'BALANCED';
      TVPlayerPolicy.defaultQuality = '720P';
      TVPlayerPolicy.maxBitrate = 2200;
      TVPlayerPolicy.preloadNext = false;
      return;
    }

    mode = 'FAST';
    TVPlayerPolicy.defaultQuality = '1080P';
    TVPlayerPolicy.maxBitrate = 4500;
    TVPlayerPolicy.preloadNext = true;
  }
}
