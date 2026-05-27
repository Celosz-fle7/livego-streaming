import 'dart:async';
import 'package:flutter/foundation.dart';

class VideoSessionManager {

  static final Map<String, dynamic> _sessions = {};

  static Timer? _heartbeatTimer;

  static void startSession({
    required String dramaId,
    required int episode,
    required String source,
  }) {
    final key = '$source-$dramaId';

    _sessions[key] = {
      'episode': episode,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };

    debugPrint('🎬 SESSION START → $key');

    _startHeartbeat();
  }

  static void updateProgress({
    required String dramaId,
    required String source,
    required double progress,
  }) {
    final key = '$source-$dramaId';

    if (_sessions[key] == null) return;

    _sessions[key]['progress'] = progress;
    _sessions[key]['updatedAt'] =
        DateTime.now().millisecondsSinceEpoch;
  }

  static Map<String, dynamic>? getSession({
    required String dramaId,
    required String source,
  }) {
    return _sessions['$source-$dramaId'];
  }

  static void endSession({
    required String dramaId,
    required String source,
  }) {
    final key = '$source-$dramaId';

    _sessions.remove(key);

    debugPrint('🛑 SESSION END → $key');
  }

  static void _startHeartbeat() {
    _heartbeatTimer ??=
        Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        debugPrint(
          '💓 ACTIVE SESSIONS → ${_sessions.length}',
        );
      },
    );
  }

  static void dispose() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _sessions.clear();
  }
}
