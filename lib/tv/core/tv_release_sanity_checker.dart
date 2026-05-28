import 'tv_low_memory_mode.dart';
import 'tv_player_policy.dart';
import 'tv_home_policy.dart';
import 'tv_image_policy.dart';
import 'tv_navigation_policy.dart';
import 'tv_render_pipeline_policy.dart';
import 'tv_network_adaptive_policy.dart';

class TVReleaseSanityChecker {
  static bool ready = true;
  static int score = 100;

  static void check() {
    score = 100;

    if (TVLowMemoryMode.enabled) {
      if (TVPlayerPolicy.maxBitrate > 1500) score -= 15;
      if (TVHomePolicy.maxItemsPerRail > 10) score -= 15;
      if (TVImagePolicy.cacheWidth > 240) score -= 15;
      if (TVNavigationPolicy.focusGlow) score -= 10;
      if (TVRenderPipelinePolicy.keepAlive) score -= 10;
      if (TVNetworkAdaptivePolicy.mode != 'SAVE_DATA') score -= 10;
    }

    if (score < 0) score = 0;

    ready = score >= 80;
  }
}
