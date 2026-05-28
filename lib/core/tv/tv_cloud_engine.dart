class TVCloudEngine {
  static bool connected = true;

  static String region = 'SGP';

  static void connect() {
    connected = true;
  }

  static void disconnect() {
    connected = false;
  }
}
