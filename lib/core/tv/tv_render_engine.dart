class TVRenderEngine {
  static int frames = 0;

  static int dropped = 0;

  static void render() {
    frames++;
  }

  static void drop() {
    dropped++;
  }
}
