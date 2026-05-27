class AuthHealthStatus {
  static bool healthy = true;
  static int unauthorized = 0;
  static String status = 'AUTH OK';

  static void unauthorizedHit() {
    unauthorized++;
    healthy = false;
    status = '401 DETECTED';
  }

  static void recovered() {
    healthy = true;
    status = 'RECOVERED';
  }
}
