import 'dart:async';

import '../../health/tv_app_health_engine.dart';
import '../../metrics/tv_live_metrics_engine.dart';
import '../../stability/tv_app_stabilizer.dart';

class TVLiveSystemLoop {

  static Timer? _timer;

  static bool running = false;

  static void start() {

    if (running) return;

    running = true;

    _timer = Timer.periodic(
      const Duration(seconds: 8),
      (_) {

        TVLiveMetricsEngine.update(
          newFps: 58,
          newMemory:
              TVAppHealthEngine.memory + 1,
          newWidgets:
              TVLiveMetricsEngine.widgets + 1,
          newRenders:
              TVLiveMetricsEngine.renders + 1,
        );

        TVAppHealthEngine.update(
          newFps:
              TVLiveMetricsEngine.fps,
          newMemory:
              TVLiveMetricsEngine.memory,
        );

        TVAppStabilizer.optimize();
      },
    );
  }

  static void stop() {

    _timer?.cancel();

    running = false;
  }
}
