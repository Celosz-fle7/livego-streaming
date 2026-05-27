class TVSafeBootRecovery {

  static bool bootRecovered =
      false;

  static Future<void>
      restore() async {

    await Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
    );

    bootRecovered = true;
  }
}
