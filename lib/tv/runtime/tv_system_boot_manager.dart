class TVSystemBootManager {

  static bool booting = false;

  static bool booted = false;

  static Future<void>
      boot() async {

    booting = true;

    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    booted = true;
    booting = false;
  }
}
