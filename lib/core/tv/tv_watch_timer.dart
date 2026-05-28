import 'dart:async';

class TVWatchTimer {
  Timer? _timer;

  int seconds = 0;

  void start(void Function(int sec) onTick) {
    stop();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        seconds++;
        onTick(seconds);
      },
    );
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    seconds = 0;
  }
}
