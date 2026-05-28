import 'dart:async';

import '../analyzer/tv_smart_analyzer.dart';
import '../decision/tv_auto_decision_engine.dart';
import 'tv_live_ai_engine.dart';

class TVAIAutoLoop {

  static Timer? _timer;

  static bool running =
      false;

  static void start() {

    if (running) return;

    running = true;

    _timer = Timer.periodic(
      const Duration(seconds: 20),
      (_) {

        TVLiveAIEngine.analyze();

        TVSmartAnalyzer.run(
          'SYSTEM HEALTH',
        );

        TVLiveAIEngine.decide();

        TVAutoDecisionEngine.make(
          'OPTIMIZE CACHE',
        );
      },
    );
  }

  static void stop() {

    _timer?.cancel();

    running = false;
  }
}
