import '../boot/tv_boot_status_engine.dart';
import '../core/tv_engine_core.dart';
import '../health/tv_app_health_engine.dart';
import '../kernel/tv_safe_app_kernel.dart';
import '../metrics/tv_live_metrics_engine.dart';
import '../stability/tv_app_stabilizer.dart';

class TVSystemInitializer {
  static Future<void> init() async {
    TVBootStatusEngine.update(
      newStatus: 'BOOTING',
      newProgress: 20,
    );

    await TVSafeAppKernel.boot();

    TVBootStatusEngine.update(
      newStatus: 'LOADING FEATURES',
      newProgress: 60,
    );

    TVEngineCore.initialize(5);

    TVLiveMetricsEngine.update(
      newFps: 60,
      newMemory: 1200,
      newWidgets: 8,
      newRenders: 1,
    );

    TVAppHealthEngine.update(
      newFps: 60,
      newMemory: 1200,
      newCache: 0,
    );

    TVAppStabilizer.stabilize();

    TVBootStatusEngine.update(
      newStatus: 'READY',
      newProgress: 100,
    );
  }
}
