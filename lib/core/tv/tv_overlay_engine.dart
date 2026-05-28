class TVOverlayEngine {
  static bool visible = true;

  static void show() {
    visible = true;
  }

  static void hide() {
    visible = false;
  }

  static void toggle() {
    visible = !visible;
  }
}
