class TVInputLock {
  static bool _locked = false;

  static bool get locked => _locked;

  static void lock() {
    _locked = true;
  }

  static void unlock() {
    _locked = false;
  }
}
