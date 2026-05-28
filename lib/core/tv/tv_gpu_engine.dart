class TVGPUEngine {
  static int usage = 20;

  static int temp = 45;

  static void update(
    int gpu,
    int temperature,
  ) {
    usage = gpu;
    temp = temperature;
  }
}
