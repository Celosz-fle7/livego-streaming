class TVNeuralEngine {
  static bool active = true;

  static int neurons = 1000000;

  static void train(
    int value,
  ) {
    neurons += value;
  }
}
