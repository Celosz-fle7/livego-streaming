import 'dart:async';

import '../alerts/tv_auto_alert_engine.dart';
import '../hud/tv_performance_hud_engine.dart';
import 'tv_system_monitor_engine.dart';

class TVAutoMonitorTimer {

  static Timer? _timer;

  static bool running =
      false;

  static void start() {

    if (running) return;

    running = true;

    TVSystemMonitorEngine.start();

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {

        TVSystemMonitorEngine.scan();

        TVPerformanceHUDEngine.update(
          newCpu:
              TVPerformanceHUDEngine.cpu + 1,
        );

        if (TVPerformanceHUDEngine.cpu > 80) {

          TVAutoAlertEngine.push(
            'HIGH CPU USAGE',
          );
        }
      },
    );
  }

  static void stop() {

    _timer?.cancel();

    running = false;

    TVSystemMonitorEngine.stop();
  }
}
