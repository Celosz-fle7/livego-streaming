import 'package:flutter/material.dart';

import '../boot/tv_boot_status_engine.dart';
import '../cache/tv_cache_stats.dart';
import '../core/tv_engine_core.dart';
import '../health/tv_app_health_engine.dart';
import '../kernel/tv_safe_app_kernel.dart';
import '../metrics/tv_live_metrics_engine.dart';
import '../runtime/live/tv_live_status_controller.dart';
import '../stability/tv_app_stabilizer.dart';
import '../widgets/tv_live_runtime_panel.dart';
import '../widgets/tv_smart_boot_panel.dart';
import '../widgets/tv_stability_panel.dart';
import '../widgets/tv_system_diagnostic_panel.dart';
import '../widgets/tv_system_health_panel.dart';
import 'tv_universal_panel.dart';

class TVSystemDashboard extends StatefulWidget {
  const TVSystemDashboard({super.key});

  @override
  State<TVSystemDashboard> createState() => _TVSystemDashboardState();
}

class _TVSystemDashboardState extends State<TVSystemDashboard> {
  @override
  Widget build(BuildContext context) {
    TVLiveStatusController.pulse();

    final cacheKeys = TVCacheStats.totalKeys();

    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 22,
        mainAxisSpacing: 22,
        childAspectRatio: 1.25,
      ),
      children: [
        TVSystemDiagnosticPanel(
          healthy: TVAppHealthEngine.healthy,
          status: TVEngineCore.initialized ? 'READY' : 'BOOTING',
        ),
        TVSystemHealthPanel(
          fps: TVAppHealthEngine.fps,
          memory: TVAppHealthEngine.memory,
          healthy: TVAppHealthEngine.healthy,
        ),
        TVSmartBootPanel(
          progress: TVBootStatusEngine.progress,
          status: TVBootStatusEngine.status,
        ),
        TVStabilityPanel(
          stable: TVAppStabilizer.stable,
          optimizations: TVAppStabilizer.optimizations,
        ),
        TVLiveRuntimePanel(
          online: TVLiveStatusController.online,
          heartbeat: TVLiveStatusController.heartbeat,
        ),
        TVUniversalPanel(
          title: 'CACHE KEYS',
          value: '$cacheKeys',
          icon: Icons.storage,
          color: Colors.cyan,
        ),
        TVUniversalPanel(
          title: 'LIVE FPS',
          value: '${TVLiveMetricsEngine.fps}',
          icon: Icons.speed,
          color: Colors.green,
        ),
        TVUniversalPanel(
          title: 'KERNEL',
          value: TVSafeAppKernel.running ? 'RUNNING' : 'IDLE',
          icon: Icons.memory,
          color: Colors.orange,
        ),
      ],
    );
  }
}
