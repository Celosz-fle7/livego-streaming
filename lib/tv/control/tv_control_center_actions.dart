import 'tv_control_center_engine.dart';
import '../terminal/tv_system_terminal_engine.dart';

class TVControlCenterActions {

  static void restartSystem() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'system.restart()',
    );
  }

  static void clearCache() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'cache.clear()',
    );
  }

  static void optimizeSystem() {

    TVControlCenterEngine.execute();

    TVSystemTerminalEngine.run(
      'system.optimize()',
    );
  }
}
