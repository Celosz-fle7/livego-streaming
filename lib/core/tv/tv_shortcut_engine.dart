class TVShortcutEngine {
  static final Map<String, String>
      shortcuts = {};

  static void set(
    String key,
    String value,
  ) {
    shortcuts[key] = value;
  }

  static String get(String key) {
    return shortcuts[key] ?? '';
  }
}
