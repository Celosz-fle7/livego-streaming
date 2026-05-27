import 'dart:async';

class TVHeroAutoRotate {
  Timer? _timer;

  void start(
    void Function() callback,
  ) {
    stop();

    _timer = Timer.periodic(
      const Duration(seconds: 8),
      (_) {
        callback();
      },
    );
  }

  void stop() {
    _timer?.cancel();
  }
}
