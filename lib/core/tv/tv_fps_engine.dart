class TVFPSEngine {
  static int fps = 60;

  static bool stable = true;

  static void drop() {
    fps = 45;
    stable = false;
  }

  static void recover() {
    fps = 60;
    stable = true;
  }
}
