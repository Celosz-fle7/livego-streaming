class TVDiagnosticEngine {

  static bool healthy = true;

  static final List<String>
      reports = [];

  static void report(
    String value,
  ) {

    reports.insert(0, value);

    if (reports.length > 30) {
      reports.removeLast();
    }
  }

  static void error(
    String value,
  ) {

    healthy = false;

    report(
      'ERROR: $value',
    );
  }

  static void recover() {

    healthy = true;
  }
}
