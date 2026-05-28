// lib/tv/screens/source_manager_screen.dart
// LIVEGO TV - SOURCE MANAGER SCREEN
// Full TV Optimization Checklist

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/drama_repository.dart';
import '../../services/api_service.dart' show ApiService, ServerStatus;
import '../../services/api_constants.dart';

class PlatformPingResult {
  final String platformId;
  final bool isOnline;
  final int pingMs;
  final DateTime checkedAt;

  const PlatformPingResult({
    required this.platformId,
    required this.isOnline,
    required this.pingMs,
    required this.checkedAt,
  });

  Color get color {
    if (pingMs == -1) return Colors.white24;
    if (!isOnline) return Colors.red;
    if (pingMs < 500) return const Color(0xFF22C55E);
    if (pingMs < 1500) return const Color(0xFFF97316);
    return Colors.red;
  }

  String get label {
    if (pingMs == -1) return '—';
    if (!isOnline) return 'Offline';
    return '${pingMs}ms';
  }
}

class TVSourceManagerScreen extends StatefulWidget {
  const TVSourceManagerScreen({super.key});
  @override
  State<TVSourceManagerScreen> createState() => _TVSourceManagerScreenState();
}

class _TVSourceManagerScreenState extends State<TVSourceManagerScreen> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _listScroll = ScrollController();

  int _selectedIndex = 0;
  bool _isSaving = false;
  bool _isCheckingAll = false;

  List<String> _activePlatformIds = [];
  Map<String, List<String>> _activeCategoryIds = {};
  String? _expandedPlatformId;

  ServerStatus? _serverStatus;
  final Map<String, PlatformPingResult> _platformPing = {};

  final List<PlatformConfig> _allPlatforms = Platforms.allTrending;
  static const int maxPlatforms = 6;
  static const int maxCategories = 2;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    _loadCachedPlatformPing();
    _loadServerStatus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _listScroll.dispose();
    super.dispose();
  }

  Future<void> _loadServerStatus() async {
    final last = await ApiService.getLastServerStatus();
    if (mounted) setState(() => _serverStatus = last);
  }

  Future<void> _loadCachedPlatformPing() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, PlatformPingResult> result = {};
    for (final p in _allPlatforms) {
      final ms = prefs.getInt('ping_ms_${p.id}');
      final online = prefs.getBool('ping_online_${p.id}');
      final ts = prefs.getInt('ping_ts_${p.id}');
      if (ms != null && online != null && ts != null) {
        result[p.id] = PlatformPingResult(
          platformId: p.id,
          isOnline: online,
          pingMs: ms,
          checkedAt: DateTime.fromMillisecondsSinceEpoch(ts),
        );
      }
    }
    if (mounted) setState(() => _platformPing.addAll(result));
  }

  Future<void> _checkAllPlatforms() async {
    if (_isCheckingAll) return;
    setState(() => _isCheckingAll = true);

    final prefs = await SharedPreferences.getInstance();
    final globalStatus = await ApiService.checkServerStatus();
    if (mounted) setState(() => _serverStatus = globalStatus);

    final futures = _allPlatforms.map((p) async {
      final start = DateTime.now().millisecondsSinceEpoch;
      bool online = false;
      int ms = 9999;
      try {
        final uri = Uri.parse('${ApiConstants.baseUrl}/api/v2/${p.id}/trending');
        final resp = await HttpClient()
            .getUrl(uri)
            .then((req) {
              req.close();
              return req.done;
            })
            .timeout(const Duration(seconds: 6));
        ms = DateTime.now().millisecondsSinceEpoch - start;
        online = resp.statusCode < 500;
      } catch (_) {
        ms = 9999;
        online = false;
      }

      final ping = PlatformPingResult(
        platformId: p.id,
        isOnline: online,
        pingMs: ms > 9000 ? 9999 : ms,
        checkedAt: DateTime.now(),
      );

      await prefs.setInt('ping_ms_${p.id}', ping.pingMs);
      await prefs.setBool('ping_online_${p.id}', ping.isOnline);
      await prefs.setInt('ping_ts_${p.id}', ping.checkedAt.millisecondsSinceEpoch);

      if (mounted) setState(() => _platformPing[p.id] = ping);
    });

    await Future.wait(futures);
    if (mounted) setState(() => _isCheckingAll = false);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> active = prefs.getStringList('tv_active_platforms_v2') ??
        List.from(Platforms.defaultTvHomeIds);
    Map<String, List<String>> cats = {};
    for (final p in _allPlatforms) {
      final savedCats = prefs.getStringList('tv_cats_${p.id}');
      cats[p.id] = savedCats != null && savedCats.isNotEmpty
          ? savedCats
          : p.categories.take(2).map((c) => c.id).toList();
    }
    if (mounted) {
      setState(() {
        _activePlatformIds = active;
        _activeCategoryIds = cats;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tv_active_platforms_v2', _activePlatformIds);
    for (final p in _allPlatforms) {
      await prefs.setStringList('tv_cats_${p.id}', _activeCategoryIds[p.id] ?? []);
    }
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Pengaturan disimpan'),
          backgroundColor: Color(0xFF06B6D4),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  void _togglePlatform(String id) {
    setState(() {
      if (_activePlatformIds.contains(id)) {
        if (_activePlatformIds.length > 1) _activePlatformIds.remove(id);
      } else {
        if (_activePlatformIds.length < maxPlatforms) {
          _activePlatformIds.add(id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Maksimal $maxPlatforms platform aktif'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  void _toggleCategory(String platformId, String catId) {
    setState(() {
      final cats = List<String>.from(_activeCategoryIds[platformId] ?? []);
      if (cats.contains(catId)) {
        if (cats.length > 1) cats.remove(catId);
      } else {
        if (cats.length < maxCategories) {
          cats.add(catId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Maksimal $maxCategories kategori per platform'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
      _activeCategoryIds[platformId] = cats;
    });
  }

  void _scrollToSelected(int index) {
    if (!_listScroll.hasClients) return;
    const itemH = 62.0;
    final offset = index * (itemH + 6.0);
    final viewport = _listScroll.position.viewportDimension;
    final current = _listScroll.offset;
    if (offset + itemH > current + viewport) {
      _listScroll.animateTo(
        (offset + itemH - viewport + 8).clamp(0.0, _listScroll.position.maxScrollExtent),
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
      );
    } else if (offset < current) {
      _listScroll.animateTo(
        offset.clamp(0.0, _listScroll.position.maxScrollExtent),
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
      );
    }
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.arrowDown) {
      if (_selectedIndex < _allPlatforms.length - 1) {
        setState(() => _selectedIndex++);
        _scrollToSelected(_selectedIndex);
      }
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp && _selectedIndex > 0) {
      setState(() => _selectedIndex--);
      _scrollToSelected(_selectedIndex);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight) {
      setState(() => _expandedPlatformId = _allPlatforms[_selectedIndex].id);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft) {
      setState(() => _expandedPlatformId = null);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.select) {
      _togglePlatform(_allPlatforms[_selectedIndex].id);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape || key == LogicalKeyboardKey.goBack) {
      Navigator.pop(context);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Color _globalServerColor() {
    if (_serverStatus == null) return Colors.white24;
    switch (_serverStatus!.colorLabel) {
      case 'green': return const Color(0xFF22C55E);
      case 'yellow': return const Color(0xFFF97316);
      default: return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D111A),
      appBar: AppBar(
        title: const Text('KELOLA SUMBER DATA', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF161B26),
        actions: [
          GestureDetector(
            onTap: _isCheckingAll ? null : _checkAllPlatforms,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                if (_isCheckingAll)
                  const SizedBox(
                    width: 14, height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF06B6D4)),
                  )
                else
                  const Icon(Icons.wifi_tethering, color: Color(0xFF06B6D4), size: 18),
                const SizedBox(width: 4),
                const Text('Cek Semua',
                    style: TextStyle(color: Color(0xFF06B6D4), fontSize: 12)),
                const SizedBox(width: 8),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: _globalServerColor(),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: _globalServerColor().withOpacity(0.6), blurRadius: 6),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Text(
                _serverStatus == null ? 'Server' : _serverStatus!.statusText,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              const SizedBox(width: 8),
            ]),
          ),
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF06B6D4)),
                  )
                : const Text('SIMPAN', style: TextStyle(color: Color(0xFF06B6D4))),
          ),
        ],
      ),
      body: FocusScope(
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleKey,
          child: Column(children: [
            RepaintBoundary(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: const Color(0xFF1F2937),
                child: Row(children: [
                  _buildBadge('Aktif: ${_activePlatformIds.length}/$maxPlatforms', const Color(0xFF06B6D4)),
                  const SizedBox(width: 10),
                  _buildLampLegend(const Color(0xFF22C55E), 'Aktif'),
                  const SizedBox(width: 8),
                  _buildLampLegend(const Color(0xFFF97316), 'Gangguan'),
                  const SizedBox(width: 8),
                  _buildLampLegend(Colors.red, 'Offline'),
                  const Spacer(),
                  const Text('▲▼ Pilih  ENTER Toggle  ► Kategori',
                      style: TextStyle(color: Colors.white24, fontSize: 10)),
                ]),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _listScroll,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _allPlatforms.length,
                itemBuilder: (_, i) {
                  final p = _allPlatforms[i];
                  final isActive = _activePlatformIds.contains(p.id);
                  final isFocused = _selectedIndex == i;
                  final isExpanded = _expandedPlatformId == p.id;
                  final activeCats = _activeCategoryIds[p.id] ?? [];
                  final ping = _platformPing[p.id];

                  return RepaintBoundary(
                    key: ValueKey('platform_${p.id}'),
                    child: Column(children: [
                      _OptimizedPlatformRow(
                        platform: p,
                        isActive: isActive,
                        isFocused: isFocused,
                        isExpanded: isExpanded,
                        activeCategories: activeCats,
                        ping: ping,
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
                    ]),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildLampLegend(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 8, height: 8,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 4)],
        ),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
    ]);
  }
}

// ═══════════════════ PLATFORM ROW ═══════════════════
class _OptimizedPlatformRow extends StatelessWidget {
  final PlatformConfig platform;
  final bool isActive;
  final bool isFocused;
  final bool isExpanded;
  final List<String> activeCategories;
  final PlatformPingResult? ping;
  final VoidCallback onToggle;
  final VoidCallback onExpand;

  const _OptimizedPlatformRow({
    required this.platform,
    required this.isActive,
    required this.isFocused,
    required this.isExpanded,
    required this.activeCategories,
    required this.ping,
    required this.onToggle,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      transform: Matrix4.identity()..scale(isFocused ? 1.02 : 1.0),
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: isFocused
            ? const Color(0xFF06B6D4).withOpacity(0.12)
            : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused ? const Color(0xFF06B6D4) : Colors.white10,
          width: isFocused ? 2 : 1,
        ),
        boxShadow: isFocused
            ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.2), blurRadius: 10)]
            : null,
      ),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Checkbox(
            value: isActive,
            activeColor: const Color(0xFF06B6D4),
            onChanged: (_) => onToggle(),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Text(
                platform.name,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white54,
                  fontWeight: isFocused ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 8),
              if (platform.isTvFriendly) _buildSmallBadge('TV', const Color(0xFF06B6D4)),
              const SizedBox(width: 4),
              ...activeCategories.take(2).map((catId) {
                final cat = platform.categories.firstWhere(
                  (c) => c.id == catId,
                  orElse: () => CategoryConfig(id: catId, name: catId),
                );
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: _buildSmallBadge(cat.name, Colors.white24),
                );
              }),
            ]),
          ),
        ),
        _buildPingIndicator(ping),
        IconButton(
          icon: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: isFocused ? const Color(0xFF06B6D4) : Colors.white38,
          ),
          onPressed: onExpand,
        ),
      ]),
    );
  }

  Widget _buildSmallBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withOpacity(0.5), width: 0.5),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPingIndicator(PlatformPingResult? ping) {
    final color = ping?.color ?? Colors.white24;
    final label = ping?.label ?? '—';
    final isChecking = ping == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isChecking)
          const SizedBox(
            width: 10, height: 10,
            child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.white38),
          )
        else
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 10, height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 6)],
            ),
          ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9)),
      ]),
    );
  }
}

// ═══════════════════ CATEGORY PANEL ═══════════════════
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
      margin: const EdgeInsets.only(left: 24, right: 12, bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B26),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kategori ${platform.name} (maks $maxCategories)',
              style: const TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: platform.categories.map((cat) {
              final isActiveCat = activeCategoryIds.contains(cat.id);
              return GestureDetector(
                onTap: () => onToggleCategory(cat.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActiveCat
                        ? const Color(0xFF06B6D4).withOpacity(0.2)
                        : Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isActiveCat ? const Color(0xFF06B6D4) : Colors.white12,
                    ),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    if (isActiveCat)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(Icons.check, color: Color(0xFF06B6D4), size: 12),
                      ),
                    Text(cat.name,
                        style: TextStyle(
                          color: isActiveCat ? const Color(0xFF06B6D4) : Colors.white54,
                          fontSize: 12,
                        )),
                  ]),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
