class TVAppStatusEngine {

  static String status =
      'BOOTING';

  static bool online = false;

  static void ready() {

    status = 'READY';

    online = true;
  }

  static void offline() {

    status = 'OFFLINE';

    online = false;
  }
}
