// lib/mobile/screens/home_screen.dart
// LIVEGO MOBILE - HOME SCREEN FINAL

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/drama_repository.dart';
import '../../utils/theme.dart';
import '../../widgets/app_logo.dart';
import '../mobile_app.dart';
import 'player_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});
  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  List<dynamic> _dramas = [];
  bool _isLoading = true;
  bool _isOffline = false;
  int _gridColumns = 3;
  List<PlatformConfig> _activePlatforms = [];
  String _selectedPlatform = '';
  List<CategoryConfig> _activeCategories = [];
  String _selectedCategory = '';
  List<Map<String, dynamic>> _bannerItems = [];
  int _bannerIndex = 0;
  final PageController _bannerPageCtrl = PageController();

  @override
  void initState() {
    super.initState();
    _loadAndInit();
  }

  @override
  void dispose() {
    _bannerPageCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAndInit() async {
    final prefs = await SharedPreferences.getInstance();
    _gridColumns = prefs.getInt('grid_columns') ?? 3;
    await _loadPlatforms(prefs);
    if (mounted) setState(() {});
    _fetchBanners();
    _fetchData();
  }

  Future<void> _loadPlatforms(SharedPreferences prefs) async {
    final savedIds = prefs.getStringList('mobile_active_platforms_v2') ?? List.from(Platforms.defaultMobileHomeIds);
    final platforms = savedIds.map((id) => Platforms.findById(id)).whereType<PlatformConfig>().toList();
    _activePlatforms = platforms.isEmpty
        ? Platforms.defaultMobileHomeIds.map((id) => Platforms.findById(id)).whereType<PlatformConfig>().toList()
        : platforms;
    _selectedPlatform = _activePlatforms.first.id;
    _loadCategories(_selectedPlatform, prefs);
  }

  void _loadCategories(String platformId, SharedPreferences prefs) {
    final p = Platforms.findById(platformId);
    if (p == null) return;
    final saved = prefs.getStringList('mobile_cats_$platformId');
    _activeCategories = (saved != null && saved.isNotEmpty)
        ? saved.map((cId) => p.categories.firstWhere((c) => c.id == cId, orElse: () => CategoryConfig(id: cId, name: cId))).toList()
        : p.categories.take(2).toList();
    _selectedCategory = _activeCategories.isNotEmpty ? _activeCategories.first.id : 'trending';
  }

  Future<void> _fetchBanners() async {
    final List<Map<String, dynamic>> banners = [];
    for (final p in _activePlatforms) {
      try {
        final data = await DramaRepository.getTrending(p.id);
        if (data.isNotEmpty) banners.add({'platform': p, 'drama': data.first});
      } catch (_) {}
      if (banners.length >= 6) break;
    }
    if (mounted) setState(() => _bannerItems = banners);
  }

  Future<void> _fetchData({bool forceRefresh = false}) async {
    if (!mounted) return;
    setState(() { _isLoading = true; _isOffline = false; });
    try {
      final data = await DramaRepository.getByCategory(_selectedPlatform, _selectedCategory);
      if (!mounted) return;
      setState(() { _dramas = data; _isLoading = false; _isOffline = data.isEmpty; });
    } catch (_) {
      if (!mounted) return;
      setState(() { _isLoading = false; _isOffline = true; });
    }
  }

  void _changePlatform(String id) async {
    setState(() => _selectedPlatform = id);
    final prefs = await SharedPreferences.getInstance();
    _loadCategories(id, prefs);
    setState(() {});
    _fetchData();
    final idx = _bannerItems.indexWhere((b) => (b['platform'] as PlatformConfig).id == id);
    if (idx >= 0 && _bannerPageCtrl.hasClients) {
      _bannerPageCtrl.animateToPage(idx, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _bannerIndex = idx);
    }
  }

  void _playVideo(dynamic drama, {String? platformId}) {
    if (drama == null) return;
    context.navigateToPlayer(id: drama['id'].toString(), source: platformId ?? _selectedPlatform, title: drama['title'] ?? 'Drama');
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: LiveGOCopilotTheme.cyan,
      backgroundColor: LiveGOCopilotTheme.surface,
      onRefresh: () => _fetchData(forceRefresh: true),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent, elevation: 0, floating: true, snap: true,
            leading: const Padding(padding: EdgeInsets.all(8), child: Icon(Icons.play_arrow, color: Color(0xFF06B6D4), size: 36)),
            title: const LiveGoAnimatedText(fontSize: 20),
            centerTitle: true,
            actions: [IconButton(icon: const Icon(Icons.refresh, color: Colors.white54, size: 20), onPressed: () => _fetchData(forceRefresh: true))],
          ),
          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (_isOffline) _buildOfflineIndicator(),
                if (_bannerItems.isNotEmpty) RepaintBoundary(child: _buildHeroBanner()),
                const SizedBox(height: 16),
                RepaintBoundary(child: _buildCategoryTabs()),
                const SizedBox(height: 16),
              ]),
            ),
          ),
          _isLoading
              ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator(color: LiveGOCopilotTheme.cyan)))
              : _dramas.isEmpty
                  ? SliverFillRemaining(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.movie_creation_outlined, color: Colors.white24, size: 52),
                      const SizedBox(height: 12),
                      const Text('Tidak ada konten', style: TextStyle(color: LiveGOCopilotTheme.textMuted)),
                      const SizedBox(height: 12),
                      TextButton(onPressed: () => _fetchData(forceRefresh: true), child: const Text('Coba Lagi', style: TextStyle(color: LiveGOCopilotTheme.cyan))),
                    ])))
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((_, i) {
                          final drama = _dramas[i];
                          return RepaintBoundary(key: ValueKey('card_${drama['id']}_$i'), child: _MobileDramaCard(drama: drama, onTap: () => _playVideo(drama)));
                        }, childCount: _dramas.length > 30 ? 30 : _dramas.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _gridColumns, childAspectRatio: 0.62, crossAxisSpacing: 10, mainAxisSpacing: 14),
                      ),
                    ),
        ],
      ),
    );
  }

  Widget _buildOfflineIndicator() {
    return Container(margin: const EdgeInsets.fromLTRB(12, 0, 12, 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.orange.withOpacity(0.15), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.withOpacity(0.4))),
      child: const Row(children: [Icon(Icons.wifi_off, color: Colors.orange, size: 14), SizedBox(width: 8), Text('Mode offline — data cache', style: TextStyle(color: Colors.orange, fontSize: 11))]));
  }

  Widget _buildHeroBanner() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 200,
        child: PageView.builder(controller: _bannerPageCtrl, itemCount: _bannerItems.length, onPageChanged: (i) => setState(() => _bannerIndex = i),
          itemBuilder: (_, i) {
            final item = _bannerItems[i];
            final drama = item['drama'] as Map<String, dynamic>;
            final platform = item['platform'] as PlatformConfig;
            return RepaintBoundary(key: ValueKey('banner_$i'),
              child: GestureDetector(onTap: () => _playVideo(drama, platformId: platform.id),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), boxShadow: [
                    BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.30), blurRadius: 18, spreadRadius: 1),
                    BoxShadow(color: Colors.black.withOpacity(0.55), blurRadius: 10, offset: const Offset(0, 4)),
                  ]),
                    child: ClipRRect(borderRadius: BorderRadius.circular(18),
                      child: Stack(children: [
                        Positioned.fill(child: CachedNetworkImage(imageUrl: drama['cover'] ?? '', fit: BoxFit.cover,
                          placeholder: (_, __) => Container(color: LiveGOCopilotTheme.surface),
                          errorWidget: (_, __, ___) => Container(color: LiveGOCopilotTheme.surface))),
                        Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(
                          begin: Alignment.centerLeft, end: Alignment.centerRight,
                          colors: [Colors.black.withOpacity(0.90), Colors.black.withOpacity(0.40), Colors.transparent], stops: const [0.0, 0.55, 1.0])))),
                        Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(
                          begin: Alignment.bottomCenter, end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.65), Colors.transparent], stops: const [0.0, 0.5])))),
                        Positioned.fill(child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.40), width: 1.5)))),
                        Positioned.fill(child: Padding(padding: const EdgeInsets.all(14),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFF06B6D4).withOpacity(0.20), borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.6))),
                                child: Text(platform.name.toUpperCase(), style: const TextStyle(color: Color(0xFF06B6D4), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
                              const SizedBox(height: 7),
                              Text(drama['title'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 5),
                              Text(drama['description'] ?? drama['synopsis'] ?? '', style: TextStyle(color: Colors.grey[400], fontSize: 11, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 10),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(color: const Color(0xFF06B6D4), borderRadius: BorderRadius.circular(20),
                                  boxShadow: [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.4), blurRadius: 8)]),
                                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                                  Icon(Icons.play_arrow, color: Colors.black, size: 14), SizedBox(width: 4),
                                  Text('Tonton Sekarang', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10))])),
                            ])),
                            const SizedBox(width: 10),
                            Container(width: 70, height: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
                                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 3))]),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(imageUrl: drama['cover'] ?? '', fit: BoxFit.cover,
                                placeholder: (_, __) => Container(color: LiveGOCopilotTheme.surface),
                                errorWidget: (_, __, ___) => Container(color: LiveGOCopilotTheme.surface))),
                          ]))),
                    ])))),
              ));
          },
        )),
      if (_bannerItems.length > 1)
        Padding(padding: const EdgeInsets.only(top: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_bannerItems.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200), width: _bannerIndex == i ? 16 : 5, height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(color: _bannerIndex == i ? const Color(0xFF06B6D4) : Colors.white24, borderRadius: BorderRadius.circular(3)))))),
      const SizedBox(height: 10),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(color: const Color(0xFF0D1520).withOpacity(0.95), borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.20), width: 1.5),
            boxShadow: [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.08), blurRadius: 12), BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)]),
          child: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(children: _activePlatforms.map((p) {
              final isSelected = _selectedPlatform == p.id;
              return GestureDetector(onTap: () => _changePlatform(p.id),
                child: AnimatedContainer(duration: const Duration(milliseconds: 150), margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(color: isSelected ? const Color(0xFF06B6D4).withOpacity(0.15) : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? const Color(0xFF06B6D4).withOpacity(0.8) : Colors.white12),
                    boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.25), blurRadius: 8)] : []),
                  child: Text(p.name, style: TextStyle(color: isSelected ? const Color(0xFF06B6D4) : LiveGOCopilotTheme.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12))));
            }).toList())))),
    ]);
  }

  Widget _buildCategoryTabs() {
    if (_activeCategories.isEmpty) return const SizedBox.shrink();
    return SingleChildScrollView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: _activeCategories.map((cat) {
        final isSelected = _selectedCategory == cat.id;
        return GestureDetector(onTap: () { setState(() => _selectedCategory = cat.id); _fetchData(); },
          child: AnimatedContainer(duration: const Duration(milliseconds: 150), margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
            decoration: BoxDecoration(gradient: isSelected ? LiveGOCopilotTheme.premiumGradient : null,
              color: isSelected ? null : LiveGOCopilotTheme.surface, borderRadius: BorderRadius.circular(30),
              border: Border.all(color: LiveGOCopilotTheme.surfaceLight)),
            child: Text(cat.name.toUpperCase(), style: TextStyle(color: isSelected ? Colors.black : LiveGOCopilotTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 12))));
      }).toList()));
  }
}

class _MobileDramaCard extends StatelessWidget {
  final dynamic drama;
  final VoidCallback onTap;
  const _MobileDramaCard({required this.drama, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap,
      child: Column(children: [
        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(imageUrl: drama['cover'] ?? '', fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: LiveGOCopilotTheme.surface),
            errorWidget: (_, __, ___) => Container(color: LiveGOCopilotTheme.surface), memCacheWidth: 200, memCacheHeight: 300))),
        const SizedBox(height: 5),
        Text(drama['title'] ?? '', style: const TextStyle(color: LiveGOCopilotTheme.textPrimary, fontSize: 10), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
        Text('${drama['chapters'] ?? 0} Ep', style: const TextStyle(color: LiveGOCopilotTheme.textMuted, fontSize: 9)),
      ]));
  }
}
