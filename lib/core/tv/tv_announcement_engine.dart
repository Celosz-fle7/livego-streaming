class TVAnnouncementEngine {
  static final List<String>
      announcements = [];

  static void push(String text) {
    announcements.insert(0, text);
  }

  static void clear() {
    announcements.clear();
  }
}
