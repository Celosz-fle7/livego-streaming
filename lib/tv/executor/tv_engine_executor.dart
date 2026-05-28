class TVEngineExecutor {

  static final List<String>
      logs = [];

  static Future<void> run(
    String task,
    Future<void> Function()
        callback,
  ) async {

    try {

      logs.add(
        'START: $task',
      );

      await callback();

      logs.add(
        'SUCCESS: $task',
      );

    } catch (e) {

      logs.add(
        'FAILED: $task',
      );
    }
  }
}
