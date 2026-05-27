class ApiRequestMetrics {
  static int getRequests = 0;
  static int postRequests = 0;
  static int putRequests = 0;

  static void get() {
    getRequests++;
  }

  static void post() {
    postRequests++;
  }

  static void put() {
    putRequests++;
  }
}
