class AuthDiagnostics {
  static int loginAttempts = 0;
  static int refreshAttempts = 0;
  static int logoutCount = 0;
  static String lastStatus = 'IDLE';

  static void login() {
    loginAttempts++;
    lastStatus = 'LOGIN';
  }

  static void refresh() {
    refreshAttempts++;
    lastStatus = 'REFRESH';
  }

  static void logout() {
    logoutCount++;
    lastStatus = 'LOGOUT';
  }
}
