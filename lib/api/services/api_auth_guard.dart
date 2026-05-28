import 'auth_token_store.dart';

class ApiAuthGuard {
  static Future<bool> authenticated() async {
    final token = await AuthTokenStore.accessToken();
    return token.isNotEmpty;
  }
}
