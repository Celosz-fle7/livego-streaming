import 'api_auth_guard.dart';

class ProtectedEndpointGuard {
  static Future<bool> allow() async {
    return await ApiAuthGuard.authenticated();
  }
}
