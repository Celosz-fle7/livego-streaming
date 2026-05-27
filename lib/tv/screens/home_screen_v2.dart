import 'package:flutter/material.dart';

import '../../core/tv/tv_row_controller.dart';
import '../../core/dracin/dracin_repository.dart';
import '../widgets/tv_poster_card.dart';
import 'detail_screen_v2.dart';

class TVHomeScreenV2 extends StatefulWidget {
  const TVHomeScreenV2({super.key});

  @override
  State<TVHomeScreenV2> createState() => _TVHomeScreenV2State();
}

class _TVHomeScreenV2State extends State<TVHomeScreenV2> {
  final ScrollController _scroll = ScrollController();

  final List<Map<String, dynamic>> _rails = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRails();
  }

  Future<void> _loadRails() async {
    final trending =
        await DracinRepository.getTrending('freereels');

    final drama =
        await DracinRepository.getTrending('dramawave');

    final short =
        await DracinRepository.getTrending('reelshort');

    if (!mounted) return;

    setState(() {
      _rails.addAll([
        {
          'title': '🔥 Trending Indonesia',
          'items': trending,
        },
        {
          'title': '🎬 DramaWave',
          'items': drama,
        },
        {
          'title': '⚡ ReelShort',
          'items': short,
        },
      ]);

      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF04D2FF),
              ),
            )
          : ListView.builder(
              controller: _scroll,
              itemCount: _rails.length,
              itemBuilder: (_, index) {
                final rail = _rails[index];

                return _RailSection(
                  title: rail['title'],
                  items: rail['items'],
                );
              },
            ),
    );
  }
}

class _RailSection extends StatefulWidget {
  final String title;
  final List items;

  const _RailSection({
    required this.title,
    required this.items,
  });

  @override
  State<_RailSection> createState() => _RailSectionState();
}

class _RailSectionState extends State<_RailSection> {
  final TVRowController _row = TVRowController();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                itemBuilder: (_, i) {
                  final item = widget.items[i];

                  return TVPosterCard(
                    index: i,
                    focusNode: _row.node(i),
                    title: item['title'] ?? '',
                    image: item['cover'] ?? '',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TVDetailScreenV2(
                            id: item['id'].toString(),
                            source: item['platform'] ?? 'freereels',
                            title: item['title'] ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
