class TVRecoveryEngine {

  static bool recovering =
      false;

  static int recovered = 0;

  static Future<void>
      recover() async {

    recovering = true;

    await Future.delayed(
      const Duration(
        milliseconds: 400,
      ),
    );

    recovered++;

    recovering = false;
  }
}
