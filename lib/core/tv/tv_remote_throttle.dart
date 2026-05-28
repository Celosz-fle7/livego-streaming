class TVRemoteThrottle {
  static int _last = 0;

  static bool allow() {
    final now =
        DateTime.now()
            .millisecondsSinceEpoch;

    if (now - _last < 90) {
      return false;
    }

    _last = now;

    return true;
  }
}
