import 'auth_token_store.dart';
import 'auth_diagnostics.dart';
import 'auth_event_logger.dart';

class ApiRefreshTokenService {
  static int refreshCount = 0;

  static Future<bool> refresh() async {
    final refreshToken = await AuthTokenStore.refreshToken();

    if (refreshToken.isEmpty) {
      return false;
    }

    refreshCount++;
    AuthDiagnostics.refresh();
    AuthEventLogger.add('TOKEN REFRESH');

    await AuthTokenStore.save(
      accessToken: 'mock-refreshed-access-token',
      refreshToken: refreshToken,
    );

    return true;
  }
}
