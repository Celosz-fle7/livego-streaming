class TVNetworkEngine {
  static bool online = true;

  static bool metered = false;

  static void offline() {
    online = false;
  }

  static void onlineMode() {
    online = true;
  }

  static void setMetered(bool value) {
    metered = value;
  }
}
