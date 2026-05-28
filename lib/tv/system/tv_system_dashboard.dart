import 'dart:async';

import 'package:flutter/material.dart';

import '../boot/tv_boot_status_engine.dart';
import '../cache/tv_cache_stats.dart';
import '../control/tv_control_center_engine.dart';
import '../control/tv_command_center_runtime.dart';
import '../core/tv_engine_core.dart';
import '../core/tv_low_memory_mode.dart';
import '../health/tv_app_health_engine.dart';
import '../hud/tv_performance_hud_engine.dart';
import '../kernel/tv_safe_app_kernel.dart';
import '../live/tv_live_status_engine.dart';
import '../metrics/tv_live_metrics_engine.dart';
import '../runtime/live/tv_live_status_controller.dart';
import '../stability/tv_app_stabilizer.dart';
import '../widgets/tv_alert_viewer_panel.dart';
import '../widgets/tv_ai_decision_viewer.dart';
import '../widgets/tv_ai_status_panel.dart';
import '../widgets/tv_control_action_panel.dart';
import '../widgets/tv_control_center_panel.dart';
import '../widgets/tv_decision_executor_panel.dart';
import '../widgets/tv_dual_console_panel.dart';
import '../widgets/tv_lightweight_panel_wrapper.dart';
import '../widgets/tv_live_runtime_panel.dart';
import '../widgets/tv_live_status_feed.dart';
import '../widgets/tv_live_system_panel.dart';
import '../widgets/tv_performance_hud_panel.dart';
import '../widgets/tv_smart_boot_panel.dart';
import '../widgets/tv_stability_panel.dart';
import '../widgets/tv_system_diagnostic_panel.dart';
import '../widgets/tv_system_health_panel.dart';
import '../ai/tv_live_ai_engine.dart';
import '../decision/tv_decision_executor.dart';
import 'tv_universal_panel.dart';

class TVSystemDashboard extends StatefulWidget {
  const TVSystemDashboard({super.key});

  @override
  State<TVSystemDashboard> createState() => _TVSystemDashboardState();
}

class _TVSystemDashboardState extends State<TVSystemDashboard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        TVLiveStatusController.pulse();

        if (!mounted) return;

        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _wrap(Widget child) {
    return TVLightweightPanelWrapper(
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cacheKeys = TVCacheStats.totalKeys();

    final panels = <Widget>[
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
      TVControlCenterPanel(
        online: TVControlCenterEngine.online,
        maintenance: TVControlCenterEngine.maintenance,
        commands: TVControlCenterEngine.commands,
      ),
      TVControlActionPanel(
        onRestart: () {
          TVCommandCenterRuntime.restart();
          setState(() {});
        },
        onClearCache: () {
          TVCommandCenterRuntime.clearMemory();
          setState(() {});
        },
        onOptimize: () {
          TVCommandCenterRuntime.optimize();
          setState(() {});
        },
        onEmergency: () {
          TVCommandCenterRuntime.emergencyMode();
          setState(() {});
        },
      ),
      TVLiveSystemPanel(
        state: TVLiveStatusEngine.state,
        users: TVLiveStatusEngine.activeUsers,
        streams: TVLiveStatusEngine.streams,
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
      TVPerformanceHUDPanel(
        fps: TVPerformanceHUDEngine.fps,
        memory: TVPerformanceHUDEngine.memory,
        cpu: TVPerformanceHUDEngine.cpu,
      ),
      TVAIStatusPanel(
        active: TVLiveAIEngine.active,
        scans: TVLiveAIEngine.scans,
        decisions: TVLiveAIEngine.decisions,
      ),
      TVDecisionExecutorPanel(
        executed: TVDecisionExecutor.executed,
      ),
      const SizedBox(
        height: 320,
        child: TVAlertViewerPanel(),
      ),
      const SizedBox(
        height: 320,
        child: TVAIDecisionViewer(),
      ),
      const SizedBox(
        height: 420,
        child: TVDualConsolePanel(),
      ),
      const SizedBox(
        height: 420,
        child: TVLiveStatusFeed(),
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.2,
      children: panels
          .take(TVLowMemoryMode.maxPanels)
          .map(_wrap)
          .toList(),
    );
  }
}
