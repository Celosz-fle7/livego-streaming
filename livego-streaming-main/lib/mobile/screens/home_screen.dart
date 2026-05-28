import 'package:flutter/material.dart';

import '../../services/drama_repository.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  bool _loading = true;
  int _category = 0;
  List<Map<String, dynamic>> _items = [];

  static const _categories = [
    'Semua',
    'Drama',
    'Romance',
    'Action',
    'Comedy',
    'Thriller',
  ];

  final _fallback = List.generate(12, (i) {
    return {
      'id': 'demo_$i',
      'title': [
        'Midnight Contract',
        'Queen of Hearts',
        'Secret Billionaire',
        'Love After Rain',
        'Shadow Deal',
        'Broken Crown',
      ][i % 6],
      'cover': '',
      'poster': '',
      'platform': 'freereels',
      'source': 'freereels',
    };
  });

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final data = await DramaRepository.getTrending(Platforms.freereels.id);
      _items = data.isEmpty ? _fallback : data;
    } catch (_) {
      _items = _fallback;
    }
    if (!mounted) return;
    setState(() => _loading = false);
  }

  String _title(Map<String, dynamic> item) {
    return '${item['title'] ?? item['name'] ?? item['drama_name'] ?? 'Untitled'}';
  }

  String _poster(Map<String, dynamic> item) {
    return '${item['poster'] ?? item['cover'] ?? item['image'] ?? item['thumbnail'] ?? ''}';
  }

  String _id(Map<String, dynamic> item) {
    return '${item['id'] ?? item['book_id'] ?? item['drama_id'] ?? _title(item)}';
  }

  String _source(Map<String, dynamic> item) {
    return '${item['source'] ?? item['platform'] ?? Platforms.freereels.id}';
  }

  void _open(Map<String, dynamic> item) {
    Navigator.pushNamed(
      context,
      '/player',
      arguments: {
        'id': _id(item),
        'source': _source(item),
        'title': _title(item),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05070D),
      body: RefreshIndicator(
        onRefresh: _load,
        color: const Color(0xFF2DD4FF),
        backgroundColor: const Color(0xFF111827),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _Header(onSearch: () {})),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
                child: _HeroBanner(
                  item: _items.isEmpty ? _fallback.first : _items.first,
                  titleOf: _title,
                  onPlay: _open,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 54,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => _CategoryChip(
                    text: _categories[i],
                    active: i == _category,
                    onTap: () => setState(() => _category = i),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: _categories.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 120),
              sliver: _loading
                  ? SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 12,
                        childAspectRatio: .58,
                      ),
                      itemBuilder: (_, __) => const _PosterSkeleton(),
                      itemCount: 9,
                    )
                  : SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 12,
                        childAspectRatio: .58,
                      ),
                      itemBuilder: (_, i) => _PosterTile(
                        item: _items[i],
                        titleOf: _title,
                        posterOf: _poster,
                        onTap: _open,
                      ),
                      itemCount: _items.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onSearch;
  const _Header({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF101827),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: Colors.white10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.movie_filter_rounded, color: Color(0xFF2DD4FF), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'LiveGO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _RoundButton(icon: Icons.history_rounded, onTap: () {}),
            const SizedBox(width: 10),
            _RoundButton(icon: Icons.favorite_rounded, onTap: () {}),
            const SizedBox(width: 10),
            _RoundButton(icon: Icons.search_rounded, onTap: onSearch),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF101827),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(icon, color: Colors.white70, size: 21),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final Map<String, dynamic> item;
  final String Function(Map<String, dynamic>) titleOf;
  final void Function(Map<String, dynamic>) onPlay;

  const _HeroBanner({
    required this.item,
    required this.titleOf,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF263BFF), Color(0xFF7C2DFF), Color(0xFF070B12)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C2DFF).withOpacity(.28),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(.55)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.14),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    'PREMIUM STREAMING',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  titleOf(item),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: () => onPlay(item),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Tonton Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const _CategoryChip({required this.text, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF7C3AED) : const Color(0xFF111827),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: active ? const Color(0xFF2DD4FF) : Colors.white10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.white60,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _PosterTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final String Function(Map<String, dynamic>) titleOf;
  final String Function(Map<String, dynamic>) posterOf;
  final void Function(Map<String, dynamic>) onTap;

  const _PosterTile({
    required this.item,
    required this.titleOf,
    required this.posterOf,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final poster = posterOf(item);
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: poster.isEmpty
                  ? const _PosterFallback()
                  : Image.network(
                      poster,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const _PosterFallback(),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Text(
                titleOf(item),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterFallback extends StatelessWidget {
  const _PosterFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1F2937),
      child: const Center(
        child: Icon(Icons.movie_rounded, color: Colors.white30, size: 38),
      ),
    );
  }
}

class _PosterSkeleton extends StatelessWidget {
  const _PosterSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
