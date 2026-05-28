class TVBackupEngine {
  static DateTime? lastBackup;

  static void backup() {
    lastBackup = DateTime.now();
  }
}
