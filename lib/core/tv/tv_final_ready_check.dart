class TVFinalReadyCheck {
  static bool player = true;
  static bool ui = true;
  static bool network = true;
  static bool storage = true;

  static bool get ready =>
      player &&
      ui &&
      network &&
      storage;
}
