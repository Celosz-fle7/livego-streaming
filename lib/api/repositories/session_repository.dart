import '../services/auth_token_store.dart';

class SessionRepository {
  static bool loggedIn = false;

  static Future<void> load() async {
    final token = await AuthTokenStore.accessToken();
    loggedIn = token.isNotEmpty;
  }

  static Future<void> logout() async {
    await AuthTokenStore.clear();
    loggedIn = false;
  }
}
