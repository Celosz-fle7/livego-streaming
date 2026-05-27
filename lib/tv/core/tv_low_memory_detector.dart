import '../health/tv_app_health_engine.dart';
import 'tv_low_memory_mode.dart';

class TVLowMemoryDetector {
  static void inspect() {
    if (TVAppHealthEngine.memory >= 2500) {
      TVLowMemoryMode.enable();
      return;
    }

    if (TVAppHealthEngine.memory < 1800) {
      TVLowMemoryMode.balanced();
    }
  }
}
