import '../../database/database_helper.dart';

class TVContinueWatching {
  static Future<List<Map<String, dynamic>>>
      load() async {
    try {
      final db = DatabaseHelper();

      final items =
          await db.getWatchHistory();

      return items
          .map<Map<String, dynamic>>(
            (e) => Map<String, dynamic>.from(e),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }
}
