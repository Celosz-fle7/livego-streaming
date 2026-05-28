class TVPlayerOverlay {
  static bool controlsVisible = false;

  static void show() {
    controlsVisible = true;
  }

  static void hide() {
    controlsVisible = false;
  }

  static void toggle() {
    controlsVisible =
        !controlsVisible;
  }
}
