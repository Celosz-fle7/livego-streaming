import 'dart:async';

import 'tv_live_event_stream.dart';
import 'tv_live_status_engine.dart';

class TVLiveSystemTimer {

  static Timer? _timer;

  static bool running =
      false;

  static void start() {

    if (running) return;

    running = true;

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {

        TVLiveStatusEngine.update(
          newUsers:
              TVLiveStatusEngine.activeUsers + 1,
          newStreams:
              TVLiveStatusEngine.streams + 1,
        );

        TVLiveEventStream.emit(
          'LIVE UPDATE',
        );
      },
    );
  }

  static void stop() {

    _timer?.cancel();

    running = false;
  }
}
