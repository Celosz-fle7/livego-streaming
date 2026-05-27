import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import 'api_headers.dart';

class ApiClient {
  static const String baseUrl = '';

  static Future<ApiResponse<dynamic>> get(String path) async {
    try {
      final uri = Uri.parse('$baseUrl$path');

      final res = await http.get(
        uri,
        headers: await ApiHeaders.json(),
      ).timeout(
        const Duration(seconds: 15),
      );

      return _handle(res);
    } catch (e) {
      return ApiResponse.fail('$e');
    }
  }

  static Future<ApiResponse<dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl$path');

      final res = await http.post(
        uri,
        headers: await ApiHeaders.json(),
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 15),
      );

      return _handle(res);
    } catch (e) {
      return ApiResponse.fail('$e');
    }
  }

  static Future<ApiResponse<dynamic>> put(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl$path');

      final res = await http.put(
        uri,
        headers: await ApiHeaders.json(),
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 15),
      );

      return _handle(res);
    } catch (e) {
      return ApiResponse.fail('$e');
    }
  }

  static ApiResponse<dynamic> _handle(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      return ApiResponse.fail('HTTP ${res.statusCode}');
    }

    if (res.body.isEmpty) {
      return ApiResponse.ok({});
    }

    return ApiResponse.ok(jsonDecode(res.body));
  }
}
