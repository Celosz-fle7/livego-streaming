import '../models/api_response.dart';
import 'api_client.dart';
import 'api_retry_policy.dart';

class ApiRetryClient {
  static Future<ApiResponse<dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    ApiResponse<dynamic> last = ApiResponse.fail('Not executed');

    for (int i = 0; i <= ApiRetryPolicy.maxRetries; i++) {
      last = await ApiClient.post(path, body);

      if (last.success) {
        return last;
      }

      await Future.delayed(
        Duration(milliseconds: ApiRetryPolicy.delayMs),
      );
    }

    return last;
  }

  static Future<ApiResponse<dynamic>> get(String path) async {
    ApiResponse<dynamic> last = ApiResponse.fail('Not executed');

    for (int i = 0; i <= ApiRetryPolicy.maxRetries; i++) {
      last = await ApiClient.get(path);

      if (last.success) {
        return last;
      }

      await Future.delayed(
        Duration(milliseconds: ApiRetryPolicy.delayMs),
      );
    }

    return last;
  }
}
