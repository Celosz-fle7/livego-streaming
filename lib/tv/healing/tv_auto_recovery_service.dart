class TVAutoRecoveryService {

  static bool active =
      true;

  static int executions =
      0;

  static Future<void>
      execute() async {

    executions++;

    await Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
    );
  }
}
