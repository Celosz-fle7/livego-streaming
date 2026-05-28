class TVPerformanceStatus {
  static bool imageOptimized = true;
  static bool railOptimized = true;
  static bool playerOptimized = true;
  static bool navigationOptimized = true;
  static bool memoryOptimized = true;
  static bool startupOptimized = true;

  static bool get ready =>
      imageOptimized &&
      railOptimized &&
      playerOptimized &&
      navigationOptimized &&
      memoryOptimized &&
      startupOptimized;
}
