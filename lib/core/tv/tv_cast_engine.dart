class TVCastEngine {
  static bool connected = false;

  static String device =
      'No Device';

  static void connect(
    String name,
  ) {
    connected = true;
    device = name;
  }

  static void disconnect() {
    connected = false;
    device = 'No Device';
  }
}
