class TVSmartBootloader {

  static bool booting =
      false;

  static bool completed =
      false;

  static int stages = 0;

  static Future<void>
      start() async {

    booting = true;

    for (int i = 0; i < 5; i++) {

      await Future.delayed(
        const Duration(
          milliseconds: 150,
        ),
      );

      stages++;
    }

    completed = true;
    booting = false;
  }
}
