class TVProductionEngine {
  static bool production = false;

  static bool monitoring = false;

  static bool reporting = false;

  static void enable() {
    production = true;
    monitoring = true;
    reporting = true;
  }
}
