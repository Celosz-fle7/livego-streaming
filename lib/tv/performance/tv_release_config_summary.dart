import '../core/tv_apk_policy.dart';
import '../core/tv_home_policy.dart';
import '../core/tv_image_policy.dart';
import '../core/tv_low_memory_mode.dart';
import '../core/tv_player_policy.dart';
import '../core/tv_release_sanity_checker.dart';
import '../core/tv_render_pipeline_policy.dart';
import 'tv_frame_budget.dart';
import 'tv_memory_budget.dart';

class TVReleaseConfigSummary {
  static Map<String, dynamic> snapshot() {
    return {
      'lowMemory': TVLowMemoryMode.enabled,
      'maxPanels': TVLowMemoryMode.maxPanels,
      'fps': TVFrameBudget.targetFps,
      'frameMs': TVFrameBudget.frameMs,
      'imageCacheMb': TVMemoryBudget.maxImageCacheMb,
      'posterSize': '${TVImagePolicy.cacheWidth}x${TVImagePolicy.cacheHeight}',
      'playerQuality': TVPlayerPolicy.defaultQuality,
      'playerBitrate': TVPlayerPolicy.maxBitrate,
      'homeRails': TVHomePolicy.maxRails,
      'itemsPerRail': TVHomePolicy.maxItemsPerRail,
      'lazyGrid': TVRenderPipelinePolicy.lazyGrid,
      'apkTarget': TVAPKPolicy.target,
      'releaseScore': TVReleaseSanityChecker.score,
      'releaseReady': TVReleaseSanityChecker.ready,
    };
  }
}
