class TVLiveChatEngine {
  static bool enabled = false;

  static final List<String>
      messages = [];

  static void enable() {
    enabled = true;
  }

  static void send(String text) {
    messages.add(text);
  }
}
