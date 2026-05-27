class TVVoidEngine {
  static bool empty = false;

  static int consumed = 0;

  static void consume() {
    empty = true;
    consumed++;
  }
}
