class TVAudioEngine {
  static double volume = 1.0;

  static bool muted = false;

  static void setVolume(
    double value,
  ) {
    volume = value.clamp(0.0, 1.0);
  }

  static void toggleMute() {
    muted = !muted;
  }
}
