class TVSessionManager {

  static bool active = false;

  static String sessionId =
      '';

  static void start(
    String id,
  ) {

    active = true;
    sessionId = id;
  }

  static void end() {

    active = false;
    sessionId = '';
  }
}
