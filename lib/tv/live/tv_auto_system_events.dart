import 'dart:async';

import 'tv_live_event_stream.dart';

class TVAutoSystemEvents {

  static Timer? _timer;

  static bool running =
      false;

  static void start() {

    if (running) return;

    running = true;

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {

        TVLiveEventStream.emit(
          'SYSTEM HEALTH OK',
        );

        TVLiveEventStream.emit(
          'LIVE LOOP ACTIVE',
        );

        TVLiveEventStream.emit(
          'MEMORY STABLE',
        );
      },
    );
  }

  static void stop() {

    _timer?.cancel();

    running = false;
  }
}
