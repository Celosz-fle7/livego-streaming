class TVSmartRemoteEngine {
  static bool connected = false;

  static String device =
      'Unknown';

  static void connect(
    String name,
  ) {
    connected = true;
    device = name;
  }
}
