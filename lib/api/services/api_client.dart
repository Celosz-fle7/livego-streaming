import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';

class ApiClient {
  static const String baseUrl = '';

  static Future<ApiResponse<dynamic>> get(String path) async {
    try {
      final uri = Uri.parse('$baseUrl$path');

      final res = await http.get(uri).timeout(
        const Duration(seconds: 15),
      );

      if (res.statusCode < 200 || res.statusCode >= 300) {
        return ApiResponse.fail('HTTP ${res.statusCode}');
      }

      return ApiResponse.ok(jsonDecode(res.body));
    } catch (e) {
      return ApiResponse.fail('$e');
    }
  }
}
