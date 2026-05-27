class ApiDiagnostics {
  static int totalRequests = 0;
  static int failedRequests = 0;
  static int cacheHits = 0;

  static void request() {
    totalRequests++;
  }

  static void fail() {
    failedRequests++;
  }

  static void cacheHit() {
    cacheHits++;
  }
}
