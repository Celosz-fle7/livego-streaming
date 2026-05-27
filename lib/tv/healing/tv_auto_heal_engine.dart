class TVAutoHealEngine {

  static bool healing =
      false;

  static int recovered = 0;

  static Future<void>
      heal() async {

    healing = true;

    await Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
    );

    recovered++;

    healing = false;
  }
}
