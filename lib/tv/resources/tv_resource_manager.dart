class TVResourceManager {

  static int images = 0;

  static int videos = 0;

  static int widgets = 0;

  static void addImage() {
    images++;
  }

  static void addVideo() {
    videos++;
  }

  static void addWidget() {
    widgets++;
  }

  static void reset() {

    images = 0;
    videos = 0;
    widgets = 0;
  }
}
