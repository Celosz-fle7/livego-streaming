// lib/mobile/screens/source_manager.dart
// OPTIMIZED WITH REPAINTBOUNDARY FOR SMOOTH SCROLLING
// Mobile: server status, platform, kategori per platform, simpan/ubah

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/drama_repository.dart';
import '../../services/api_service.dart' show ApiService, ServerStatus;

class SourceManagerPage extends StatefulWidget {
  const SourceManagerPage({super.key});
  @override
  State<SourceManagerPage> createState() => _SourceManagerPageState();
}

class _SourceManagerPageState extends State<SourceManagerPage> {
  final List<PlatformConfig> _allPlatforms = Platforms.allTrending;
  List<String> _activePlatformIds = [];
  Map<String, List<String>> _activeCategoryIds = {};
  String? _expandedPlatformId;
  ServerStatus? _serverStatus;
  bool _isCheckingServer = false;
  bool _isSaving = false;
  bool _hasChanges = false;

  static const int maxPlatforms = 6;
  static const int maxCategories = 2;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadServerStatus();
  }

  Future<void> _loadServerStatus() async {
    final last = await ApiService.getLastServerStatus();
    if (mounted) setState(() => _serverStatus = last);
  }

  Future<void> _checkServer() async {
    if (_isCheckingServer) return;
    setState(() => _isCheckingServer = true);
    final status = await ApiService.checkServerStatus();
    if (mounted) setState(() {
      _serverStatus = status;
      _isCheckingServer = false;
    });
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> active = prefs.getStringList('mobile_active_platforms_v2') ??
        List.from(Platforms.defaultMobileHomeIds);
    Map<String, List<String>> cats = {};
    for (final p in _allPlatforms) {
      final savedCats = prefs.getStringList('mobile_cats_${p.id}');
      cats[p.id] = savedCats != null && savedCats.isNotEmpty
          ? savedCats
          : p.categories.take(2).map((c) => c.id).toList();
    }
    if (mounted) setState(() {
      _activePlatformIds = active;
      _activeCategoryIds = cats;
    });
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('mobile_active_platforms_v2', _activePlatformIds);
    for (final p in _allPlatforms) {
      await prefs.setStringList(
          'mobile_cats_${p.id}', _activeCategoryIds[p.id] ?? []);
    }
    if (mounted) {
      setState(() { _isSaving = false; _hasChanges = false; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('✓ Pengaturan disimpan'),
        backgroundColor: Color(0xFF06B6D4),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context, true);
    }
  }

  void _togglePlatform(String id) {
    setState(() {
      _hasChanges = true;
      if (_activePlatformIds.contains(id)) {
        if (_activePlatformIds.length > 1) _activePlatformIds.remove(id);
      } else {
        if (_activePlatformIds.length < maxPlatforms) {
          _activePlatformIds.add(id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Maksimal $maxPlatforms platform aktif'),
            backgroundColor: Colors.orange,
          ));
        }
      }
    });
  }

  void _toggleCategory(String platformId, String catId) {
    setState(() {
      _hasChanges = true;
      final cats = List<String>.from(_activeCategoryIds[platformId] ?? []);
      if (cats.contains(catId)) {
        if (cats.length > 1) cats.remove(catId);
      } else {
        if (cats.length < maxCategories) {
          cats.add(catId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Maksimal $maxCategories kategori per platform'),
            backgroundColor: Colors.orange,
          ));
        }
      }
      _activeCategoryIds[platformId] = cats;
    });
  }

  Color get _serverColor {
    if (_serverStatus == null) return Colors.white38;
    switch (_serverStatus!.colorLabel) {
      case 'green':  return Colors.green;
      case 'yellow': return Colors.yellow;
      default:       return Colors.red;
    }
  }

  String get _serverLabel {
    if (_serverStatus == null) return 'Belum dicek';
    return _serverStatus!.statusText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D14),
      appBar: AppBar(
        title: const Text('Kelola Sumber Data',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF111622),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, _hasChanges),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Color(0xFF06B6D4)))
                : const Text('Simpan',
                    style: TextStyle(color: Color(0xFF06B6D4))),
          ),
        ],
      ),
      body: Column(children: [
        // Status server
        RepaintBoundary(child: _buildServerStatus()),

        // Info bar
        RepaintBoundary(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF111622),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.4)),
                ),
                child: Text(
                  'Aktif: ${_activePlatformIds.length}/$maxPlatforms',
                  style: const TextStyle(
                      color: Color(0xFF06B6D4),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Tap platform untuk aktif/nonaktif\n► untuk kategori',
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ]),
          ),
        ),

        // List platform - OPTIMIZED
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: _allPlatforms.length,
            itemBuilder: (_, i) {
              final p = _allPlatforms[i];
              final isActive = _activePlatformIds.contains(p.id);
              final isExpanded = _expandedPlatformId == p.id;
              final activeCats = _activeCategoryIds[p.id] ?? [];

              return RepaintBoundary(
                key: ValueKey('platform_${p.id}'),
                child: Column(
                  children: [
                    _OptimizedPlatformRow(
                      platform: p,
                      isActive: isActive,
                      isExpanded: isExpanded,
                      activeCategories: activeCats,
                      onToggle: () => _togglePlatform(p.id),
                      onExpand: () => setState(() {
                        _expandedPlatformId = isExpanded ? null : p.id;
                      }),
                    ),
                    if (isExpanded)
                      _OptimizedCategoryPanel(
                        platform: p,
                        activeCategoryIds: activeCats,
                        onToggleCategory: (catId) => _toggleCategory(p.id, catId),
                        maxCategories: maxCategories,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildServerStatus() {
    return GestureDetector(
      onTap: _checkServer,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: const Color(0xFF0D1117),
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 12, height: 12,
            decoration: BoxDecoration(
              color: _isCheckingServer ? Colors.white38 : _serverColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: (_isCheckingServer ? Colors.white38 : _serverColor)
                        .withOpacity(0.5),
                    blurRadius: 6)
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isCheckingServer ? 'Memeriksa server...' : _serverLabel,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                if (_serverStatus != null)
                  Text(
                    'Terakhir dicek: ${_fmt(_serverStatus!.checkedAt)}',
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(children: [
              if (_isCheckingServer)
                const SizedBox(
                    width: 12, height: 12,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54))
              else
                const Icon(Icons.refresh, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              const Text('Cek', style: TextStyle(color: Colors.white54, fontSize: 12)),
            ]),
          ),
        ]),
      ),
    );
  }

  String _fmt(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

// ============================================================
// OPTIMIZED PLATFORM ROW - Separate widget
// ============================================================
class _OptimizedPlatformRow extends StatelessWidget {
  final PlatformConfig platform;
  final bool isActive;
  final bool isExpanded;
  final List<String> activeCategories;
  final VoidCallback onToggle;
  final VoidCallback onExpand;

  const _OptimizedPlatformRow({
    required this.platform,
    required this.isActive,
    required this.isExpanded,
    required this.activeCategories,
    required this.onToggle,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF06B6D4).withOpacity(0.08)
              : const Color(0xFF111622),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? const Color(0xFF06B6D4).withOpacity(0.5)
                : const Color(0xFF14242D),
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(children: [
          // Custom Switch
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 22,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF06B6D4) : Colors.white12,
              borderRadius: BorderRadius.circular(11),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 18, height: 18,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    platform.name,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (platform.isTvFriendly)
                    _buildBadgeSmall('TV', const Color(0xFF06B6D4)),
                  const SizedBox(width: 4),
                  if (isActive)
                    const Icon(Icons.star, color: Colors.amber, size: 13),
                ]),
                const SizedBox(height: 2),
                if (activeCategories.isNotEmpty)
                  Text(
                    activeCategories
                        .map((cId) {
                          final cat = platform.categories.firstWhere(
                            (c) => c.id == cId,
                            orElse: () => CategoryConfig(id: cId, name: cId),
                          );
                          return cat.name;
                        })
                        .join(' · '),
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
              ],
            ),
          ),
          // Expand button
          GestureDetector(
            onTap: onExpand,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_right,
                color: Colors.white38,
                size: 20,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildBadgeSmall(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ============================================================
// OPTIMIZED CATEGORY PANEL - Separate widget
// ============================================================
class _OptimizedCategoryPanel extends StatelessWidget {
  final PlatformConfig platform;
  final List<String> activeCategoryIds;
  final Function(String) onToggleCategory;
  final int maxCategories;

  const _OptimizedCategoryPanel({
    required this.platform,
    required this.activeCategoryIds,
    required this.onToggleCategory,
    required this.maxCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 8, bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih kategori untuk ${platform.name} (maks $maxCategories)',
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: platform.categories.map((cat) {
              final isActiveCat = activeCategoryIds.contains(cat.id);
              return GestureDetector(
                onTap: () => onToggleCategory(cat.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: isActiveCat
                        ? const Color(0xFF06B6D4).withOpacity(0.15)
                        : Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isActiveCat ? const Color(0xFF06B6D4) : Colors.white12,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isActiveCat)
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(Icons.check, color: Color(0xFF06B6D4), size: 12),
                        ),
                      Text(
                        cat.name,
                        style: TextStyle(
                          color: isActiveCat ? const Color(0xFF06B6D4) : Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
