class TVBootStatusEngine {

  static String status =
      'IDLE';

  static int progress = 0;

  static void update({
    required String newStatus,
    required int newProgress,
  }) {

    status = newStatus;
    progress = newProgress;
  }
}
