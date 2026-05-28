import 'package:flutter/foundation.dart';

import '../dracin/dracin_repository.dart';

class TVHomeRail {
  final String title;
  final String platform;
  final List items;

  const TVHomeRail({
    required this.title,
    required this.platform,
    required this.items,
  });
}

class TVHomeController extends ChangeNotifier {
  final List<TVHomeRail> rails = [];

  bool loading = false;

  Map<String, dynamic>? hero;

  Future<void> load() async {
    if (loading) return;

    loading = true;
    notifyListeners();

    try {
      final trending =
          await DracinRepository.getTrending(
        'freereels',
      );

      final drama =
          await DracinRepository.getTrending(
        'dramawave',
      );

      final short =
          await DracinRepository.getTrending(
        'reelshort',
      );

      if (trending.isNotEmpty) {
        hero = trending.first;
      }

      rails.clear();

      rails.addAll([
        TVHomeRail(
          title: '🔥 Trending Indonesia',
          platform: 'freereels',
          items: trending,
        ),
        TVHomeRail(
          title: '🎬 DramaWave',
          platform: 'dramawave',
          items: drama,
        ),
        TVHomeRail(
          title: '⚡ ReelShort',
          platform: 'reelshort',
          items: short,
        ),
      ]);
    } catch (e) {
      debugPrint(
        'TVHomeController load error: $e',
      );
    }

    loading = false;
    notifyListeners();
  }
}
