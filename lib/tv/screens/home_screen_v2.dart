import 'package:flutter/material.dart';

import '../../core/dracin/dracin_repository.dart';
import '../../core/tv/tv_image_cache.dart';
import '../../core/tv/tv_row_controller.dart';

import '../widgets/tv_hero_banner.dart';
import '../widgets/tv_loading_skeleton.dart';
import '../widgets/tv_poster_card.dart';

import 'detail_screen_v2.dart';
import 'player_screen.dart';

class TVHomeScreenV2 extends StatefulWidget {
  const TVHomeScreenV2({super.key});

  @override
  State<TVHomeScreenV2> createState() => _TVHomeScreenV2State();
}

class _TVHomeScreenV2State extends State<TVHomeScreenV2> {
  final ScrollController _scroll = ScrollController();

  final List<Map<String, dynamic>> _rails = [];

  bool _loading = true;

  Map<String, dynamic>? _hero;

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

    await TVImageCache.precacheMany(
      context,
      trending,
    );

    await TVImageCache.precacheMany(
      context,
      drama,
    );

    await TVImageCache.precacheMany(
      context,
      short,
    );

    if (trending.isNotEmpty) {
      _hero = trending.first;
    }

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
          ? const TVLoadingSkeleton()
          : CustomScrollView(
              controller: _scroll,
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHero(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final rail = _rails[index];

                      return _RailSection(
                        title: rail['title'],
                        items: rail['items'],
                      );
                    },
                    childCount: _rails.length,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHero() {
    if (_hero == null) {
      return const SizedBox();
    }

    return TVHeroBanner(
      title: _hero!['title'] ?? '',
      image: _hero!['cover'] ?? '',
      synopsis:
          _hero!['description'] ??
          'Drama pilihan terbaik untuk Android TV Indonesia.',
      onPlay: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TVPlayerScreen(
              id: _hero!['id'].toString(),
              source: _hero!['platform'] ?? 'freereels',
              title: _hero!['title'] ?? '',
            ),
          ),
        );
      },
      onDetail: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TVDetailScreenV2(
              id: _hero!['id'].toString(),
              source: _hero!['platform'] ?? 'freereels',
              title: _hero!['title'] ?? '',
            ),
          ),
        );
      },
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
                            source:
                                item['platform'] ?? 'freereels',
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
