class TVOblivionEngine {
  static bool erased = false;

  static int voids = 0;

  static void erase() {
    erased = true;
    voids++;
  }
}
