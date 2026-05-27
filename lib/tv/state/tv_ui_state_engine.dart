class TVUIStateEngine {

  static bool loading = false;

  static bool sidebarOpen =
      false;

  static bool dialogVisible =
      false;

  static int activeIndex = 0;

  static void setLoading(
    bool value,
  ) {

    loading = value;
  }

  static void openSidebar() {

    sidebarOpen = true;
  }

  static void closeSidebar() {

    sidebarOpen = false;
  }

  static void setIndex(
    int index,
  ) {

    activeIndex = index;
  }
}
