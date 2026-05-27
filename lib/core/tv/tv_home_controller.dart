import 'package:flutter/foundation.dart';

import '../dracin/dracin_repository.dart';
import '../models/tv_home_section.dart';

class TVHomeController {

  static Future<List<TVHomeSection>>
      loadHome() async {

    final List<TVHomeSection>
        sections = [];

    try {

      // =========================
      // FREEREELS
      // =========================

      final freereels =
          await DracinRepository
              .getTrending(
        'freereels',
      );

      if (freereels.isNotEmpty) {
        sections.add(
          TVHomeSection(
            id: 'freereels',
            title: 'FreeReels',
            items: freereels,
          ),
        );
      }

      // =========================
      // DRAMAWAVE
      // =========================

      final dramawave =
          await DracinRepository
              .getTrending(
        'dramawave',
      );

      if (dramawave.isNotEmpty) {
        sections.add(
          TVHomeSection(
            id: 'dramawave',
            title: 'DramaWave',
            items: dramawave,
          ),
        );
      }

      // =========================
      // REELSHORT
      // =========================

      final reelshort =
          await DracinRepository
              .getTrending(
        'reelshort',
      );

      if (reelshort.isNotEmpty) {
        sections.add(
          TVHomeSection(
            id: 'reelshort',
            title: 'ReelShort',
            items: reelshort,
          ),
        );
      }

      debugPrint(
        '📺 TV HOME SECTIONS → ${sections.length}',
      );

      return sections;

    } catch (e) {

      debugPrint(
        '❌ TV HOME ERROR → $e',
      );

      return [];
    }
  }
}
