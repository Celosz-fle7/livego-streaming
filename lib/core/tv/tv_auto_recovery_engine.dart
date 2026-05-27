class TVAutoRecoveryEngine {
  static bool enabled = true;

  static int recovered = 0;

  static void recover() {
    recovered++;
  }
}
