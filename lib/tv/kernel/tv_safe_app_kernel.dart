class TVSafeAppKernel {

  static bool initialized =
      false;

  static bool running =
      false;

  static Future<void>
      boot() async {

    initialized = true;

    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    running = true;
  }

  static void shutdown() {

    running = false;
  }
}
