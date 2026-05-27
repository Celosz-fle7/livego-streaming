class TVCoreAppStatus {
  static bool homeReady = true;
  static bool playerReady = true;
  static bool focusReady = true;
  static bool remoteReady = true;
  static bool errorUiReady = true;
  static bool loadingReady = true;

  static bool get ready =>
      homeReady &&
      playerReady &&
      focusReady &&
      remoteReady &&
      errorUiReady &&
      loadingReady;
}
