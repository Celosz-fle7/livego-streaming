class TVReadyEngine {
  static bool ui = true;
  static bool player = true;
  static bool backend = true;
  static bool release = true;

  static bool get ready =>
      ui &&
      player &&
      backend &&
      release;
}
