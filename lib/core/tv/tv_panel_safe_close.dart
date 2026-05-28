class TVPanelSafeClose {
  static bool canClose = true;

  static bool tryClose() {
    if (!canClose) {
      return false;
    }

    return true;
  }
}
