class TVMemoryResourceTracker {

  static int allocated = 0;

  static int released = 0;

  static void allocate(
    int value,
  ) {

    allocated += value;
  }

  static void release(
    int value,
  ) {

    released += value;
  }

  static int usage() {

    return allocated - released;
  }
}
