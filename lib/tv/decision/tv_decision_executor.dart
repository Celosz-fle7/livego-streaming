import '../cache/tv_cache_cleaner.dart';
import '../control/tv_command_center_runtime.dart';
import '../live/tv_live_event_stream.dart';
import '../stability/tv_app_stabilizer.dart';

class TVDecisionExecutor {
  static int executed = 0;

  static void execute(String decision) {
    executed++;

    if (decision == 'OPTIMIZE CACHE') {
      TVCacheCleaner.clean();
      TVCommandCenterRuntime.optimize();
      TVLiveEventStream.emit('EXECUTED: OPTIMIZE CACHE');
      return;
    }

    if (decision == 'STABILIZE APP') {
      TVAppStabilizer.stabilize();
      TVLiveEventStream.emit('EXECUTED: STABILIZE APP');
      return;
    }

    TVLiveEventStream.emit('EXECUTED: $decision');
  }
}
