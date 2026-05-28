import 'auth_token_store.dart';

class ApiHeaders {
  static Future<Map<String, String>> json() async {
    final token = await AuthTokenStore.accessToken();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
}
