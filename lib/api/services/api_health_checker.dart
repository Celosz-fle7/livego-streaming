import 'api_client.dart';

class ApiHealthChecker {
  static bool healthy = false;
  static String status = 'UNKNOWN';

  static Future<void> check() async {
    final res = await ApiClient.get('/health');

    healthy = res.success;
    status = res.success ? 'HEALTHY' : 'UNAVAILABLE';
  }
}
