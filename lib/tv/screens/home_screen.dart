// lib/tv/screens/home_screen.dart
// LIVEGO TV - HOME SCREEN FINAL (FIXED)

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/drama_repository.dart';
import 'player_screen.dart';
import 'search_screen.dart';
import 'favorite_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class TVHomeScreen extends StatefulWidget {
  const TVHomeScreen({super.key});
  @override
  State<TVHomeScreen> createState() => _TVHomeScreenState();
}

class _TVHomeScreenState extends State<TVHomeScreen> {
  final FocusNode _rootFocus = FocusNode();
  final ScrollController _scroll = ScrollController();

  String _focusArea = 'banner';
  bool _isMenuFocused = false;
  int _menuIndex = 0;
  Timer? _sidebarTimer;
  Timer? _bannerTimer;

  List<PlatformConfig> _platforms = [];
  int _platformIndex = 0;
  int _categoryIndex = 0;

  List _dramas = [];
  List _bannerItems = [];
  bool _isLoading = false;
  int _gridIndex = 0;
  int _bannerIndex = 0;

  static const int _cols = 6;
  static const double _cardAspect = 0.65;

  static const _menuIcons = [
    Icons.home_rounded, Icons.search_rounded, Icons.history_rounded,
    Icons.favorite_rounded, Icons.settings_rounded,
  ];
  static const _menuLabels = ['Home', 'Cari', 'Histori', 'Favorit', 'Set'];

  @override
  void initState() {
    super.initState();
    _loadPlatforms();
    WidgetsBinding.instance.addPostFrameCallback((_) => _rootFocus.requestFocus());
  }

  @override
  void dispose() {
    _rootFocus.dispose();
    _scroll.dispose();
    _bannerTimer?.cancel();
    _sidebarTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadPlatforms() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('tv_active_platforms_v2');
    final ids = (saved != null && saved.isNotEmpty) ? saved : Platforms.defaultTvHomeIds;
    if (mounted) {
      setState(() {
        _platforms = ids.map(Platforms.findById).whereType<PlatformConfig>().toList();
        _platformIndex = 0;
        _categoryIndex = 0;
      });
    }
    _loadContent();
  }

  Future<void> _loadContent() async {
    if (_platforms.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final data = await DramaRepository.getByCategory(
        _platforms[_platformIndex].id,
        _categories.isNotEmpty ? _categories[_categoryIndex].id : 'trending',
      );
      if (mounted) {
        setState(() {
          _dramas = data;
          _gridIndex = 0;
          _bannerItems = data.take(5).map((d) => {'drama': d, 'platform': _platforms[_platformIndex]}).toList();
        });
      }
      _startBannerTimer();
    } catch (_) {}
    if (mounted) setState(() => _isLoading = false);
  }

  List<CategoryConfig> get _categories => _platforms.isNotEmpty ? _platforms[_platformIndex].categories : [];

  void _startBannerTimer() {
    _bannerTimer?.cancel();
    if (_bannerItems.length < 2) return;
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) setState(() => _bannerIndex = (_bannerIndex + 1) % _bannerItems.length);
    });
  }

  void _resetSidebarTimer() {
    _sidebarTimer?.cancel();
    _sidebarTimer = Timer(const Duration(seconds: 5), () {
      if (mounted && _isMenuFocused) {
        setState(() => _isMenuFocused = false);
        _rootFocus.requestFocus();
      }
    });
  }

  void _navigateMenu(int idx) {
    setState(() {
      _isMenuFocused = false;
      _focusArea = 'banner';
    });
    _sidebarTimer?.cancel();
    _rootFocus.requestFocus();
    switch (idx) {
      case 0:
        _loadContent();
        break;
      case 1:
        Navigator.push(context, _route(const TVSearchScreen()));
        break;
      case 2:
        Navigator.push(context, _route(const TVHistoryScreen()));
        break;
      case 3:
        Navigator.push(context, _route(const TVFavoriteScreen()));
        break;
      case 4:
        Navigator.push(context, _route(const TVSettingsScreen()));
        break;
    }
  }

  PageRoute _route(Widget page) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
    transitionDuration: const Duration(milliseconds: 180),
  );

  void _playDrama(Map<String, dynamic> drama) {
    Navigator.push(context, _route(TVPlayerScreen(
      id: drama['id']?.toString() ?? '',
      source: _platforms[_platformIndex].id,
      title: drama['title'] ?? '',
    )));
  }

  void _scrollToGrid(int idx) {
    if (!_scroll.hasClients) return;
    final headerH = 200.0 + 60 + 60 + 32;
    final row = idx ~/ _cols;
    final cw = MediaQuery.of(context).size.width - 88;
    final itemH = cw / _cols / _cardAspect;
    final target = headerH + row * (itemH + 10);
    _scroll.animateTo(
      target.clamp(0.0, _scroll.position.maxScrollExtent),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('Keluar Aplikasi?', style: TextStyle(color: Colors.white)),
        content: const Text('Yakin ingin keluar dari LiveGO TV?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('BATAL', style: TextStyle(color: Colors.grey))),
          TextButton(onPressed: () { Navigator.pop(ctx); SystemNavigator.pop(); }, child: const Text('KELUAR', style: TextStyle(color: Color(0xFF06B6D4)))),
        ],
      ),
    );
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final k = event.logicalKey;

    if (_isMenuFocused) {
      _resetSidebarTimer();
      if (k == LogicalKeyboardKey.arrowUp && _menuIndex > 0) {
        setState(() => _menuIndex--);
      } else if (k == LogicalKeyboardKey.arrowDown && _menuIndex < _menuIcons.length - 1) {
        setState(() => _menuIndex++);
      } else if (k == LogicalKeyboardKey.enter || k == LogicalKeyboardKey.select) {
        _navigateMenu(_menuIndex);
      } else if (k == LogicalKeyboardKey.arrowRight || k == LogicalKeyboardKey.escape || k == LogicalKeyboardKey.goBack) {
        setState(() => _isMenuFocused = false);
        _rootFocus.requestFocus();
      }
      return KeyEventResult.handled;
    }

    if (k == LogicalKeyboardKey.escape || k == LogicalKeyboardKey.goBack) {
      _showExitDialog();
      return KeyEventResult.handled;
    }

    if (k == LogicalKeyboardKey.enter || k == LogicalKeyboardKey.select) {
      if (_focusArea == 'grid' && _dramas.isNotEmpty) {
        _playDrama(_dramas[_gridIndex] as Map<String, dynamic>);
      } else if (_focusArea == 'banner' && _bannerItems.isNotEmpty) {
        _playDrama(_bannerItems[_bannerIndex]['drama'] as Map<String, dynamic>);
      } else if (_focusArea == 'platform') {
        _loadContent();
      } else if (_focusArea == 'category') {
        _loadContent();
      }
      return KeyEventResult.handled;
    }

    if (k == LogicalKeyboardKey.arrowUp) {
      if (_focusArea == 'grid') {
        if (_gridIndex >= _cols) {
          setState(() => _gridIndex -= _cols);
          _scrollToGrid(_gridIndex);
        } else if (_categories.isNotEmpty) {
          setState(() {
            _focusArea = 'category';
            _categoryIndex = (_gridIndex % _cols).clamp(0, _categories.length - 1);
          });
        }
      } else if (_focusArea == 'category') {
        setState(() => _focusArea = 'platform');
      } else if (_focusArea == 'platform') {
        setState(() => _focusArea = 'banner');
      } else if (_focusArea == 'banner') {
        setState(() {
          _isMenuFocused = true;
          _menuIndex = 0;
        });
        _resetSidebarTimer();
      }
      return KeyEventResult.handled;
    }

    if (k == LogicalKeyboardKey.arrowDown) {
      if (_focusArea == 'banner') {
        if (_platforms.isNotEmpty) {
          setState(() => _focusArea = 'platform');
        } else if (_categories.isNotEmpty) {
          setState(() => _focusArea = 'category');
        } else if (_dramas.isNotEmpty) {
          setState(() => _focusArea = 'grid');
        }
      } else if (_focusArea == 'platform') {
        if (_categories.isNotEmpty) {
          setState(() => _focusArea = 'category');
        } else if (_dramas.isNotEmpty) {
          setState(() {
            _focusArea = 'grid';
            _gridIndex = 0;
          });
        }
      } else if (_focusArea == 'category') {
        if (_dramas.isNotEmpty) {
          setState(() {
            _focusArea = 'grid';
            _gridIndex = 0;
          });
        }
      } else if (_focusArea == 'grid') {
        if (_gridIndex + _cols < _dramas.length) {
          setState(() => _gridIndex += _cols);
          _scrollToGrid(_gridIndex);
        }
      }
      return KeyEventResult.handled;
    }

    if (k == LogicalKeyboardKey.arrowLeft) {
      if (_focusArea == 'grid') {
        if (_gridIndex % _cols == 0) {
          setState(() {
            _isMenuFocused = true;
            _menuIndex = 0;
          });
          _resetSidebarTimer();
        } else {
          setState(() => _gridIndex--);
          _scrollToGrid(_gridIndex);
        }
      } else if (_focusArea == 'category') {
        if (_categoryIndex > 0) setState(() => _categoryIndex--);
      } else if (_focusArea == 'platform') {
        if (_platformIndex > 0) setState(() => _platformIndex--);
      } else if (_focusArea == 'banner') {
        setState(() {
          _isMenuFocused = true;
          _menuIndex = 0;
        });
        _resetSidebarTimer();
      }
      return KeyEventResult.handled;
    }

    if (k == LogicalKeyboardKey.arrowRight) {
      if (_focusArea == 'grid') {
        if (_gridIndex % _cols < _cols - 1 && _gridIndex < _dramas.length - 1) {
          setState(() => _gridIndex++);
          _scrollToGrid(_gridIndex);
        }
      } else if (_focusArea == 'category') {
        if (_categoryIndex < _categories.length - 1) setState(() => _categoryIndex++);
      } else if (_focusArea == 'platform') {
        if (_platformIndex < _platforms.length - 1) setState(() => _platformIndex++);
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final cw = MediaQuery.of(context).size.width - 88;
    return Scaffold(
      backgroundColor: const Color(0xFF080C12),
      body: Focus(
        focusNode: _rootFocus,
        autofocus: true,
        onKeyEvent: _onKey,
        child: Stack(
          children: [
            Positioned.fill(
              left: 72,
              child: RepaintBoundary(
                child: SingleChildScrollView(
                  controller: _scroll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      RepaintBoundary(child: _buildBanner(cw)),
                      const SizedBox(height: 8),
                      RepaintBoundary(child: _buildPlatformRow(cw)),
                      const SizedBox(height: 8),
                      RepaintBoundary(child: _buildCategoryRow(cw)),
                      const SizedBox(height: 16),
                      RepaintBoundary(child: _buildGrid(cw)),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 72,
              child: RepaintBoundary(child: _buildSidebar()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return FocusScope(
      child: Container(
        color: const Color(0xFF0D111A),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildLogo(),
            const SizedBox(height: 6),
            _buildLogoText(),
            const SizedBox(height: 16),
            Container(width: 40, height: 1, color: Colors.white.withOpacity(0.08)),
            const SizedBox(height: 16),
            Expanded(child: Center(child: _buildCircleMenu())),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 56,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0284C7), Color(0xFF06B6D4)]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.4), blurRadius: 12)],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28),
          Positioned(
            right: 6,
            bottom: 6,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: const Icon(Icons.play_arrow_rounded, color: Color(0xFF0284C7), size: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoText() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF0284C7)]).createShader(b),
          child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF0284C7)]).createShader(b),
          child: const Text('GO', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),
      ],
    );
  }

  Widget _buildCircleMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_menuIcons.length, (i) {
        final f = _isMenuFocused && _menuIndex == i;
        return Padding(
          padding: EdgeInsets.only(bottom: i < _menuIcons.length - 1 ? 12 : 0),
          child: GestureDetector(
            onTap: () => _navigateMenu(i),
            child: AnimatedScale(
              scale: f ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: f ? const Color(0xFF06B6D4).withOpacity(0.2) : Colors.white.withOpacity(0.04),
                  shape: BoxShape.circle,
                  border: Border.all(color: f ? const Color(0xFF06B6D4) : Colors.white.withOpacity(0.08), width: f ? 2 : 1),
                  boxShadow: f ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.4), blurRadius: 14)] : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_menuIcons[i], color: f ? const Color(0xFF06B6D4) : Colors.white70, size: 20),
                    const SizedBox(height: 1),
                    Text(_menuLabels[i], style: TextStyle(color: f ? const Color(0xFF06B6D4) : Colors.white38, fontSize: 7, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBanner(double w) {
    if (_bannerItems.isEmpty) {
      return Container(
        width: w,
        height: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(color: const Color(0xFF1A2232), borderRadius: BorderRadius.circular(20)),
        child: const Center(child: CircularProgressIndicator(color: Color(0xFF06B6D4))),
      );
    }
    final item = _bannerItems[_bannerIndex];
    final drama = item['drama'] as Map<String, dynamic>;
    final platform = item['platform'] as PlatformConfig;
    final f = _focusArea == 'banner';

    return Container(
      width: w,
      height: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: drama['cover'] ?? '',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
                    errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A2232)),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.black.withOpacity(0.88), Colors.transparent],
                        stops: const [0.0, 0.6],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                        stops: const [0.0, 0.5],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  bottom: 18,
                  right: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _badge(platform.name.toUpperCase(), const Color(0xFF06B6D4)),
                      const SizedBox(height: 7),
                      Text(
                        drama['title'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        drama['description'] ?? drama['sinopsis'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: f ? const Color(0xFF06B6D4) : const Color(0xFF06B6D4).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.black, size: 16),
                            SizedBox(width: 6),
                            Text('Tonton', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 14,
                  bottom: 14,
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(drama['cover'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (f)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF06B6D4), width: 3),
                  boxShadow: [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.5), blurRadius: 20)],
                ),
              ),
            ),
          if (_bannerItems.length > 1)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_bannerItems.length, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: i == _bannerIndex ? 20 : 6,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: i == _bannerIndex ? const Color(0xFF06B6D4) : Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlatformRow(double w) {
    if (_platforms.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      width: w,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1520).withOpacity(0.95),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.2)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _platforms.asMap().entries.map((e) {
              final i = e.key, p = e.value;
              final sel = _platformIndex == i;
              final f = _focusArea == 'platform' && sel;
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: _chip(p.name, sel, f, () {
                  setState(() {
                    _platformIndex = i;
                    _categoryIndex = 0;
                  });
                  _loadContent();
                }),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(double w) {
    if (_categories.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      width: w,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1520).withOpacity(0.95),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.2)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.asMap().entries.map((e) {
              final i = e.key, c = e.value;
              final sel = _categoryIndex == i;
              final f = _focusArea == 'category' && sel;
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: _chip(c.name, sel, f, () {
                  setState(() => _categoryIndex = i);
                  _loadContent();
                }),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, bool sel, bool f, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: sel ? const Color(0xFF06B6D4).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: f ? const Color(0xFF06B6D4) : (sel ? const Color(0xFF06B6D4).withOpacity(0.5) : Colors.white12),
            width: f ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: sel || f ? const Color(0xFF06B6D4) : Colors.white70,
            fontWeight: sel || f ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(double w) {
    if (_isLoading) {
      return SizedBox(height: 300, width: w, child: const Center(child: CircularProgressIndicator(color: Color(0xFF06B6D4))));
    }
    if (_dramas.isEmpty) {
      return SizedBox(height: 200, width: w, child: const Center(child: Text('Tidak ada konten', style: TextStyle(color: Colors.white38))));
    }
    return SizedBox(
      width: w,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _cols,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: _cardAspect,
          ),
          itemCount: _dramas.length,
          itemBuilder: (_, i) => _DramaCard(
            drama: _dramas[i] as Map<String, dynamic>,
            isFocused: _focusArea == 'grid' && _gridIndex == i,
            onTap: () => _playDrama(_dramas[i] as Map<String, dynamic>),
          ),
        ),
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }
}

class _DramaCard extends StatelessWidget {
  final Map<String, dynamic> drama;
  final bool isFocused;
  final VoidCallback onTap;
  const _DramaCard({required this.drama, required this.isFocused, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.04 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: isFocused ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.4), blurRadius: 16)] : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: drama['cover'] ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
                errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A2232)),
              ),
              if (isFocused)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF06B6D4), width: 3),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        drama['title'] ?? '',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${drama['chapters'] ?? 0} Ep',
                        style: const TextStyle(color: Colors.white60, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
