import 'auth_token_store.dart';

class ApiRefreshTokenService {
  static int refreshCount = 0;

  static Future<bool> refresh() async {
    final refreshToken = await AuthTokenStore.refreshToken();

    if (refreshToken.isEmpty) {
      return false;
    }

    refreshCount++;

    await AuthTokenStore.save(
      accessToken: 'mock-refreshed-access-token',
      refreshToken: refreshToken,
    );

    return true;
  }
}
