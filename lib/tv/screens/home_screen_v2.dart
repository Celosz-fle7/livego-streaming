import 'package:flutter/material.dart';

import '../../core/tv/tv_home_controller.dart';
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
  final TVHomeController _controller = TVHomeController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    await _controller.load();

    if (!mounted) return;

    for (final rail in _controller.rails) {
      await TVImageCache.precacheMany(
        context,
        rail.items,
      );
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: _controller.loading
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
                      final rail = _controller.rails[index];

                      return _RailSection(
                        title: rail.title,
                        platform: rail.platform,
                        items: rail.items,
                      );
                    },
                    childCount: _controller.rails.length,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHero() {
    final hero = _controller.hero;

    if (hero == null) {
      return const SizedBox();
    }

    return TVHeroBanner(
      title: hero['title'] ?? '',
      image: hero['cover'] ?? '',
      synopsis: hero['synopsis'] ??
          hero['description'] ??
          'Drama pilihan terbaik untuk Android TV Indonesia.',
      onPlay: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TVPlayerScreen(
              id: hero['id'].toString(),
              source: hero['platform'] ?? 'freereels',
              title: hero['title'] ?? '',
            ),
          ),
        );
      },
      onDetail: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TVDetailScreenV2(
              id: hero['id'].toString(),
              source: hero['platform'] ?? 'freereels',
              title: hero['title'] ?? '',
            ),
          ),
        );
      },
    );
  }
}

class _RailSection extends StatefulWidget {
  final String title;
  final String platform;
  final List items;

  const _RailSection({
    required this.title,
    required this.platform,
    required this.items,
  });

  @override
  State<_RailSection> createState() => _RailSectionState();
}

class _RailSectionState extends State<_RailSection> {
  late final TVRowController _row;

  @override
  void initState() {
    super.initState();
    _row = TVRowController(
      sectionId: widget.title,
    );
  }

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
                controller: _row.scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                itemCount: widget.items.length,
                itemBuilder: (_, i) {
                  final item = widget.items[i];

                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: TVPosterCard(
                      title: item['title'] ?? '',
                      image: item['cover'] ?? '',
                      focused: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TVDetailScreenV2(
                              id: item['id'].toString(),
                              source: widget.platform,
                              title: item['title'] ?? '',
                            ),
                          ),
                        );
                      },
                    ),
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
