import '../models/api_response.dart';
import '../models/user_profile.dart';
import '../services/auth_token_store.dart';

class AuthRepository {
  static Future<ApiResponse<UserProfile>> mockLogin({
    required String name,
  }) async {
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
    await AuthTokenStore.clear();
  }
}
