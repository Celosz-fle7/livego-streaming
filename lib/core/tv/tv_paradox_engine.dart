class TVParadoxEngine {
  static bool paradox = false;

  static int loops = 0;

  static void activate() {
    paradox = true;
    loops++;
  }
}
