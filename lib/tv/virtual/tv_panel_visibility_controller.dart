class TVPanelVisibilityController {

  static final Map<String, bool>
      visibility = {};

  static void show(
    String key,
  ) {

    visibility[key] = true;
  }

  static void hide(
    String key,
  ) {

    visibility[key] = false;
  }

  static bool visible(
    String key,
  ) {

    return visibility[key] ?? true;
  }
}
