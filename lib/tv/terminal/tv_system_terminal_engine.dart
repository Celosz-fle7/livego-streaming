class TVSystemTerminalEngine {

  static final List<String>
      output = [];

  static void run(
    String command,
  ) {

    output.insert(
      0,
      'EXECUTED: $command',
    );

    if (output.length > 200) {
      output.removeLast();
    }
  }
}
