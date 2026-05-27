class TVErrorEngine {
  static final List<String>
      errors = [];

  static void add(String text) {
    errors.add(text);
  }

  static void clear() {
    errors.clear();
  }

  static bool get hasError =>
      errors.isNotEmpty;
}
