class TVControlCenterEngine {

  static bool online = true;

  static bool maintenance =
      false;

  static int commands = 0;

  static void execute() {

    commands++;
  }

  static void enableMaintenance() {

    maintenance = true;
  }

  static void disableMaintenance() {

    maintenance = false;
  }
}
