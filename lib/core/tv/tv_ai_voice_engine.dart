class TVAIVoiceEngine {
  static bool active = false;

  static String lastCommand = '';

  static void listen(
    String command,
  ) {
    active = true;
    lastCommand = command;
  }
}
