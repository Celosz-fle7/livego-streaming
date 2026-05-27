class TVSeekEngine {
  static double seek(
    double current,
    double delta,
    double max,
  ) {
    return (current + delta)
        .clamp(0.0, max);
  }
}
