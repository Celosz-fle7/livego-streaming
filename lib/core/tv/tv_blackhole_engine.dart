class TVBlackholeEngine {
  static bool consuming = false;

  static int absorbed = 0;

  static void absorb() {
    consuming = true;
    absorbed++;
  }
}
