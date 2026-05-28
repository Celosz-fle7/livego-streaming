class TVRailLazyBuilder {
  static bool shouldBuild(
    int index,
    double scrollOffset,
  ) {
    final target =
        index * 320;

    return (target - scrollOffset)
            .abs() <
        1800;
  }
}
