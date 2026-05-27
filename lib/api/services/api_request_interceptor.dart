import 'api_request_logger.dart';

class ApiRequestInterceptor {
  static void before(String method, String path) {
    ApiRequestLogger.log('INTERCEPT $method $path');
  }

  static void after(String method, String path, bool success) {
    ApiRequestLogger.log(
      'DONE $method $path ${success ? "OK" : "FAIL"}',
    );
  }
}
