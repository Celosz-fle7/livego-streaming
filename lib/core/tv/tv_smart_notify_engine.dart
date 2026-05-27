class TVSmartNotifyEngine {
  static bool enabled = true;

  static int notifications = 0;

  static void push() {
    notifications++;
  }
}
