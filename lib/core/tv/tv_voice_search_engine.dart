class TVVoiceSearchEngine {
  static bool enabled = true;

  static String lastQuery = '';

  static void search(
    String value,
  ) {
    lastQuery = value;
  }
}
