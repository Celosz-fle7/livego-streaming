import '../alerts/tv_auto_alert_engine.dart';
import '../decision/tv_auto_decision_engine.dart';
import '../live/tv_live_event_stream.dart';
import '../terminal/tv_system_terminal_engine.dart';
import 'tv_low_memory_mode.dart';

class TVLowMemoryCleaner {
  static void trim() {
    final max = TVLowMemoryMode.maxLogs;

    if (TVLiveEventStream.events.length > max) {
      TVLiveEventStream.events.removeRange(
        max,
        TVLiveEventStream.events.length,
      );
    }

    if (TVSystemTerminalEngine.output.length > max) {
      TVSystemTerminalEngine.output.removeRange(
        max,
        TVSystemTerminalEngine.output.length,
      );
    }

    if (TVAutoAlertEngine.alerts.length > max) {
      TVAutoAlertEngine.alerts.removeRange(
        max,
        TVAutoAlertEngine.alerts.length,
      );
    }

    if (TVAutoDecisionEngine.decisions.length > max) {
      TVAutoDecisionEngine.decisions.removeRange(
        max,
        TVAutoDecisionEngine.decisions.length,
      );
    }
  }
}
