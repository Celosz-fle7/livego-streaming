import 'tv_cache_limiter.dart';
import 'tv_fps_optimizer.dart';

class TVBoot {
  static void initialize() {
    TVCacheLimiter.apply();

    TVFPSOptimizer.optimize();
  }
}
