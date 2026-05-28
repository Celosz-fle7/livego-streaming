class TVRemoteNavigationCore {
  static int row = 0;
  static int column = 0;

  static void up() {
    if (row > 0) row--;
  }

  static void down() {
    row++;
  }

  static void left() {
    if (column > 0) column--;
  }

  static void right() {
    column++;
  }

  static void reset() {
    row = 0;
    column = 0;
  }
}
