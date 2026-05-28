import '../live/tv_live_event_stream.dart';
import '../terminal/tv_system_terminal_engine.dart';
import 'tv_control_center_engine.dart';

class TVCommandCenterRuntime {

  static void restart() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'runtime.restart()',
    );

    TVLiveEventStream.emit(
      'SYSTEM RESTARTED',
    );
  }

  static void optimize() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'runtime.optimize()',
    );

    TVLiveEventStream.emit(
      'SYSTEM OPTIMIZED',
    );
  }

  static void clearMemory() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'memory.clear()',
    );

    TVLiveEventStream.emit(
      'MEMORY CLEARED',
    );
  }

  static void emergencyMode() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'emergency.enable()',
    );

    TVLiveEventStream.emit(
      'EMERGENCY MODE ENABLED',
    );
  }
}
