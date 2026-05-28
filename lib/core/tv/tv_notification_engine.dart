class TVNotificationEngine {
  static final List<String>
      notifications = [];

  static void push(String text) {
    notifications.insert(0, text);
  }

  static void clear() {
    notifications.clear();
  }
}
