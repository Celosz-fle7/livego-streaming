class TVUserSession {
  static bool loggedIn = false;

  static bool premium = false;

  static String username = 'Guest';

  static void login(
    String user,
  ) {
    loggedIn = true;
    username = user;
  }

  static void logout() {
    loggedIn = false;
    premium = false;
    username = 'Guest';
  }

  static void activatePremium() {
    premium = true;
  }
}
