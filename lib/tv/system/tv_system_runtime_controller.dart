import '../ai/tv_ai_auto_loop.dart';
import '../live/tv_auto_system_events.dart';
import '../live/tv_live_system_timer.dart';
import '../monitor/tv_auto_monitor_timer.dart';
import '../runtime/live/tv_live_system_loop.dart';

class TVSystemRuntimeController {
  static bool active = false;

  static void start() {
    if (active) return;
    active = true;

    TVLiveSystemLoop.start();
    TVLiveSystemTimer.start();
    TVAutoSystemEvents.start();
    TVAutoMonitorTimer.start();
    TVAIAutoLoop.start();
  }

  static void stop() {
    active = false;

    TVLiveSystemLoop.stop();
    TVLiveSystemTimer.stop();
    TVAutoSystemEvents.stop();
    TVAutoMonitorTimer.stop();
    TVAIAutoLoop.stop();
  }
}
