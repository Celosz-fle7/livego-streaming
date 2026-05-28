import 'dart:async';

class TVPlayerAutoHide {
  Timer? _timer;

  void start(
    void Function() onHide,
  ) {
    stop();

    _timer = Timer(
      const Duration(seconds: 5),
      onHide,
    );
  }

  void stop() {
    _timer?.cancel();
  }
}
