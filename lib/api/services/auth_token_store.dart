import '../cache/local_store.dart';

class AuthTokenStore {
  static const _accessKey = 'auth_access_token';
  static const _refreshKey = 'auth_refresh_token';

  static Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    await LocalStore.set(_accessKey, accessToken);
    await LocalStore.set(_refreshKey, refreshToken);
  }

  static Future<String> accessToken() async {
    return '${await LocalStore.get(_accessKey) ?? ''}';
  }

  static Future<String> refreshToken() async {
    return '${await LocalStore.get(_refreshKey) ?? ''}';
  }

  static Future<void> clear() async {
    await LocalStore.remove(_accessKey);
    await LocalStore.remove(_refreshKey);
  }
}
