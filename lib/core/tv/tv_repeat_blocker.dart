class TVRepeatBlocker {
  static int _last = 0;

  static bool allow() {
    final now =
        DateTime.now()
            .millisecondsSinceEpoch;

    if (now - _last < 80) {
      return false;
    }

    _last = now;

    return true;
  }
}
