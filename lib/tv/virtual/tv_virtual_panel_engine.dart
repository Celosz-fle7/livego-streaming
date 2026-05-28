class TVVirtualPanelEngine {

  static final List<String>
      activePanels = [];

  static int maxVisible = 6;

  static void register(
    String panel,
  ) {

    if (activePanels.contains(panel)) {
      return;
    }

    activePanels.add(panel);

    if (activePanels.length >
        maxVisible) {

      activePanels.removeAt(0);
    }
  }

  static bool visible(
    String panel,
  ) {

    return activePanels.contains(
      panel,
    );
  }
}
