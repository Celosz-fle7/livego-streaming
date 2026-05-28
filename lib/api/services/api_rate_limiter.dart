class ApiRateLimiter {
  static DateTime? _last;
  static int minGapMs = 250;

  static Future<void> wait() async {
    final now = DateTime.now();

    if (_last == null) {
      _last = now;
      return;
    }

    final diff = now.difference(_last!).inMilliseconds;

    if (diff < minGapMs) {
      await Future.delayed(
        Duration(milliseconds: minGapMs - diff),
      );
    }

    _last = DateTime.now();
  }
}
