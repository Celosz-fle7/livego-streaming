class ApiConnectivityStatus {
  static bool online = true;
  static String lastError = '';
  static int failures = 0;

  static void success() {
    online = true;
    lastError = '';
  }

  static void fail(String error) {
    online = false;
    lastError = error;
    failures++;
  }
}
