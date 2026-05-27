import 'package:flutter/material.dart';

import '../boot/tv_boot_status_engine.dart';
import '../cache/tv_cache_stats.dart';
import '../core/tv_engine_core.dart';
import '../health/tv_app_health_engine.dart';
import '../kernel/tv_safe_app_kernel.dart';
import '../metrics/tv_live_metrics_engine.dart';
import '../stability/tv_app_stabilizer.dart';
import '../widgets/tv_smart_boot_panel.dart';
import '../widgets/tv_stability_panel.dart';
import '../widgets/tv_system_diagnostic_panel.dart';
import '../widgets/tv_system_health_panel.dart';
import '../widgets/tv_universal_panel.dart';

class TVSystemDashboard extends StatelessWidget {
  const TVSystemDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
        TVUniversalPanel(
          title: 'FEATURES',
          value: '${TVEngineCore.loadedFeatures}',
          icon: Icons.extension,
          color: Colors.purple,
        ),
      ],
    );
  }
}
