class TVCoreAppController {
  static int activeTab = 0;
  static bool loading = false;
  static String error = '';

  static void setTab(int index) {
    activeTab = index;
  }

  static void startLoading() {
    loading = true;
    error = '';
  }

  static void stopLoading() {
    loading = false;
  }

  static void setError(String value) {
    error = value;
    loading = false;
  }

  static void clearError() {
    error = '';
  }
}
