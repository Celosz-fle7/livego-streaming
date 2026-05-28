import '../core/tv_home_policy.dart';
import '../core/tv_image_policy.dart';
import '../core/tv_navigation_policy.dart';
import '../core/tv_player_policy.dart';
import '../core/tv_render_pipeline_policy.dart';
import 'tv_frame_budget.dart';
import 'tv_lazy_render_policy.dart';
import 'tv_memory_budget.dart';

class TVGlobalPerformanceBootstrap {

  static bool initialized =
      false;

  static void initialize() {

    if (initialized) return;

    initialized = true;

    TVFrameBudget.lowEnd();

    TVMemoryBudget.lowEnd();

    TVLazyRenderPolicy.lowEnd();

    TVHomePolicy.apply();

    TVImagePolicy.apply();

    TVNavigationPolicy.apply();

    TVPlayerPolicy.apply();

    TVRenderPipelinePolicy.apply();
  }
}
