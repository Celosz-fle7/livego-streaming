import 'tv_performance_manager.dart';

class TVAutoOptimizer {

  static void optimize(
    int memory,
  ) {

    if (memory > 3000) {

      TVPerformanceManager
          .enableLowMemory();

    } else {

      TVPerformanceManager
          .disableLowMemory();
    }
  }
}
