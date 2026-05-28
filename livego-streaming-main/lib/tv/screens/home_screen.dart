import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/drama_repository.dart';

class TVHomeScreen extends StatefulWidget {
  const TVHomeScreen({super.key});

  @override
  State<TVHomeScreen> createState() => _TVHomeScreenState();
}

class _TVHomeScreenState extends State<TVHomeScreen> {
  bool _navOpen = false;
  bool _loading = true;
  int _menuIndex = 0;
  List<Map<String, dynamic>> _items = [];

  final FocusNode _rootFocus = FocusNode(debugLabel: 'tv-home-root');

  final _fallback = List.generate(18, (i) {
    return {
      'id': 'tv_demo_$i',
      'title': [
        'The Silent Heiress',
        'Dragon Contract',
        'Royal Revenge',
        'Love In Neon',
        'Hidden CEO',
        'Night Runner',
      ][i % 6],
      'poster': '',
      'cover': '',
      'source': 'freereels',
      'platform': 'freereels',
    };
  });

  static const _menus = [
    (Icons.home_rounded, 'Home', '/tv_home'),
    (Icons.search_rounded, 'Search', '/tv_search'),
    (Icons.favorite_rounded, 'Favorit', '/tv_favorite'),
    (Icons.history_rounded, 'Histori', '/tv_history'),
    (Icons.person_rounded, 'Akun', '/tv_account'),
    (Icons.settings_rounded, 'Setting', '/tv_settings'),
  ];

  @override
  void initState() {
    super.initState();
    _load();
    WidgetsBinding.instance.addPostFrameCallback((_) => _rootFocus.requestFocus());
  }

  @override
  void dispose() {
    _rootFocus.dispose();
    super.dispose();
  }

  Future<void> _load() async {
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
      '/tv_player',
      arguments: {
        'id': _id(item),
        'source': _source(item),
        'title': _title(item),
      },
    );
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      if (!_navOpen) {
        setState(() => _navOpen = true);
        return KeyEventResult.handled;
      }
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowRight && _navOpen) {
      setState(() => _navOpen = false);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final featured = _items.isEmpty ? _fallback.first : _items.first;

    return Focus(
      focusNode: _rootFocus,
      autofocus: true,
      onKeyEvent: _handleKey,
      child: Scaffold(
        backgroundColor: const Color(0xFF05070D),
        body: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-.45, -.65),
                    radius: 1.2,
                    colors: [
                      const Color(0xFF3520A3).withOpacity(.65),
                      const Color(0xFF05070D),
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.only(left: _navOpen ? 250 : 92),
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF2DD4FF)))
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(34, 30, 34, 20),
                            child: _TVHero(
                              item: featured,
                              titleOf: _title,
                              onPlay: _open,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: _TVChips()),
                        SliverToBoxAdapter(
                          child: _TVRail(
                            title: 'Trending Now',
                            items: _items,
                            titleOf: _title,
                            posterOf: _poster,
                            onTap: _open,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _TVRail(
                            title: 'Latest Update',
                            items: _items.reversed.toList(),
                            titleOf: _title,
                            posterOf: _poster,
                            onTap: _open,
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 80)),
                      ],
                    ),
            ),
            _TVSideNav(
              open: _navOpen,
              selected: _menuIndex,
              menus: _menus,
              onHoverOpen: () => setState(() => _navOpen = true),
              onClose: () => setState(() => _navOpen = false),
              onSelect: (i) {
                setState(() => _menuIndex = i);
                final route = _menus[i].$3;
                if (route != '/tv_home') Navigator.pushNamed(context, route);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TVSideNav extends StatelessWidget {
  final bool open;
  final int selected;
  final List<(IconData, String, String)> menus;
  final VoidCallback onHoverOpen;
  final VoidCallback onClose;
  final ValueChanged<int> onSelect;

  const _TVSideNav({
    required this.open,
    required this.selected,
    required this.menus,
    required this.onHoverOpen,
    required this.onClose,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverOpen(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        width: open ? 250 : 86,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 28),
        decoration: BoxDecoration(
          color: const Color(0xF0080B12),
          border: const Border(right: BorderSide(color: Colors.white10)),
          boxShadow: open
              ? const [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 40,
                    offset: Offset(16, 0),
                  ),
                ]
              : null,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF2DD4FF), Color(0xFF7C3AED)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                  ),
                  if (open) ...[
                    const SizedBox(width: 12),
                    const Text(
                      'LiveGO',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 34),
              ...List.generate(menus.length, (i) {
                final active = i == selected;
                final item = menus[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TVNavItem(
                    icon: item.$1,
                    label: item.$2,
                    open: open,
                    active: active,
                    onTap: () => onSelect(i),
                  ),
                );
              }),
              const Spacer(),
              if (open)
                TextButton.icon(
                  onPressed: onClose,
                  icon: const Icon(Icons.chevron_left_rounded),
                  label: const Text('Sembunyikan'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TVNavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool open;
  final bool active;
  final VoidCallback onTap;

  const _TVNavItem({
    required this.icon,
    required this.label,
    required this.open,
    required this.active,
    required this.onTap,
  });

  @override
  State<_TVNavItem> createState() => _TVNavItemState();
}

class _TVNavItemState extends State<_TVNavItem> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active || _focused;
    return Focus(
      onFocusChange: (v) => setState(() => _focused = v),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF7C3AED).withOpacity(.86) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: active ? const Color(0xFF2DD4FF) : Colors.transparent, width: 2),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.white, size: 27),
              if (widget.open) ...[
                const SizedBox(width: 14),
                Text(
                  widget.label,
                  style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TVHero extends StatelessWidget {
  final Map<String, dynamic> item;
  final String Function(Map<String, dynamic>) titleOf;
  final void Function(Map<String, dynamic>) onPlay;

  const _TVHero({required this.item, required this.titleOf, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF141B37), Color(0xFF431F94), Color(0xFF070B12)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(.22),
            blurRadius: 60,
            offset: const Offset(0, 28),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 42,
            top: 44,
            bottom: 40,
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.12),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Text(
                    'LIVEGO PREMIUM ORIGINAL',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  titleOf(item),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 54,
                    height: .98,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Streaming drama pendek premium dengan tampilan cinematic, cepat, dan ringan untuk Android TV.',
                  maxLines: 2,
                  style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.5),
                ),
                const Spacer(),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () => onPlay(item),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Tonton'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Favorit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 50,
            bottom: 40,
            child: Container(
              width: 230,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: const Color(0xFF111827),
                border: Border.all(color: Colors.white12),
              ),
              child: const Icon(Icons.movie_rounded, color: Colors.white24, size: 100),
            ),
          ),
        ],
      ),
    );
  }
}

class _TVChips extends StatelessWidget {
  const _TVChips();

  @override
  Widget build(BuildContext context) {
    const chips = ['Semua', 'Populer', 'Romance', 'Action', 'Comedy', 'Thriller', 'Dubbing'];
    return SizedBox(
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: i == 0 ? const Color(0xFF7C3AED) : const Color(0xFF111827),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: i == 0 ? const Color(0xFF2DD4FF) : Colors.white10),
          ),
          child: Text(
            chips[i],
            style: TextStyle(
              color: i == 0 ? Colors.white : Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: chips.length,
      ),
    );
  }
}

class _TVRail extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final String Function(Map<String, dynamic>) titleOf;
  final String Function(Map<String, dynamic>) posterOf;
  final void Function(Map<String, dynamic>) onTap;

  const _TVRail({
    required this.title,
    required this.items,
    required this.titleOf,
    required this.posterOf,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 22, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => _TVPosterCard(
                item: items[i],
                titleOf: titleOf,
                posterOf: posterOf,
                onTap: onTap,
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 18),
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _TVPosterCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final String Function(Map<String, dynamic>) titleOf;
  final String Function(Map<String, dynamic>) posterOf;
  final void Function(Map<String, dynamic>) onTap;

  const _TVPosterCard({required this.item, required this.titleOf, required this.posterOf, required this.onTap});

  @override
  State<_TVPosterCard> createState() => _TVPosterCardState();
}

class _TVPosterCardState extends State<_TVPosterCard> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final poster = widget.posterOf(widget.item);
    return Focus(
      onFocusChange: (value) => setState(() => _focused = value),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.item),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 160),
          scale: _focused ? 1.06 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 170,
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: _focused ? const Color(0xFF2DD4FF) : Colors.white10,
                width: _focused ? 3 : 1,
              ),
              boxShadow: _focused
                  ? [
                      BoxShadow(
                        color: const Color(0xFF2DD4FF).withOpacity(.35),
                        blurRadius: 28,
                      ),
                    ]
                  : null,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: poster.isEmpty
                      ? const Center(child: Icon(Icons.movie_rounded, color: Colors.white24, size: 58))
                      : Image.network(
                          poster,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.movie_rounded, color: Colors.white24, size: 58)),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.titleOf(widget.item),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
