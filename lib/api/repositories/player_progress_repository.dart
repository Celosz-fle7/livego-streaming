import '../cache/local_store.dart';
import '../models/api_response.dart';
import '../services/api_client.dart';

class PlayerProgressRepository {
  static Future<ApiResponse<bool>> save({
    required String contentId,
    required int position,
    required int duration,
  }) async {
    final payload = {
      'contentId': contentId,
      'position': position,
      'duration': duration,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    await LocalStore.set(
      'progress_$contentId',
      payload,
    );

    final res = await ApiClient.post(
      '/progress',
      payload,
    );

    if (!res.success) {
      return ApiResponse.ok(true);
    }

    return ApiResponse.ok(true);
  }

  static Future<Map<String, dynamic>> local(
    String contentId,
  ) async {
    final raw = await LocalStore.get(
      'progress_$contentId',
    );

    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }

    return {};
  }
}
