import '../models/api_response.dart';
import '../models/login_result.dart';
import '../models/user_profile.dart';
import '../services/api_client.dart';
import '../services/auth_diagnostics.dart';
import '../services/auth_event_logger.dart';
import '../services/auth_token_store.dart';

class AuthRepository {
  static Future<ApiResponse<UserProfile>> login({
    required String username,
    required String password,
  }) async {
    AuthDiagnostics.login();
    AuthEventLogger.add('LOGIN ATTEMPT: $username');

    final res = await ApiClient.post(
      '/auth/login',
      {
        'username': username,
        'password': password,
      },
    );

    if (!res.success) {
      AuthEventLogger.add('LOGIN FAILED: ${res.error}');
      return ApiResponse.fail(res.error);
    }

    final result = LoginResult.fromJson(
      Map<String, dynamic>.from(res.data),
    );

    await AuthTokenStore.save(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    );

    AuthEventLogger.add('LOGIN SUCCESS');

    return ApiResponse.ok(result.profile);
  }

  static Future<ApiResponse<UserProfile>> mockLogin({
    required String name,
  }) async {
    AuthDiagnostics.login();
    AuthEventLogger.add('MOCK LOGIN');

    final profile = UserProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      avatar: '',
    );

    await AuthTokenStore.save(
      accessToken: 'mock-access-token',
      refreshToken: 'mock-refresh-token',
    );

    return ApiResponse.ok(profile);
  }

  static Future<void> logout() async {
    AuthDiagnostics.logout();
    AuthEventLogger.add('LOGOUT');

    await AuthTokenStore.clear();
  }
}
