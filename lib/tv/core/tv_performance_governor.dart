import 'tv_low_memory_mode.dart';
import 'tv_render_pipeline_policy.dart';
import 'tv_navigation_policy.dart';
import 'tv_player_policy.dart';

class TVPerformanceGovernor {

  static String mode = 'BALANCED';

  static void low() {

    mode = 'LOW';

    TVLowMemoryMode.enable();

    TVRenderPipelinePolicy.apply();

    TVNavigationPolicy.apply();

    TVPlayerPolicy.apply();
  }

  static void balanced() {

    mode = 'BALANCED';

    TVLowMemoryMode.balanced();

    TVRenderPipelinePolicy.apply();

    TVNavigationPolicy.apply();

    TVPlayerPolicy.apply();
  }

  static void high() {

    mode = 'HIGH';

    TVLowMemoryMode.disable();

    TVRenderPipelinePolicy.apply();

    TVNavigationPolicy.apply();

    TVPlayerPolicy.apply();
  }
}
