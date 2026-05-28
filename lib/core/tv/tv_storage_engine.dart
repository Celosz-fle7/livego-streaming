class TVStorageEngine {
  static double usedGB = 12.4;

  static double totalGB = 64.0;

  static double get percent {
    return usedGB / totalGB;
  }
}
