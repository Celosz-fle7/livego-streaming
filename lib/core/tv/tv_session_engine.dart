class TVSessionEngine {
  static DateTime? startedAt;

  static int launches = 0;

  static void start() {
    launches++;
    startedAt = DateTime.now();
  }
}
