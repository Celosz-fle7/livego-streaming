// lib/tv/screens/account_screen.dart
// LIVEGO TV - ACCOUNT SCREEN (FIXED)

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_service.dart';

class TVAccountScreen extends StatefulWidget {
  const TVAccountScreen({super.key});
  @override
  State<TVAccountScreen> createState() => _TVAccountScreenState();
}

class _TVAccountScreenState extends State<TVAccountScreen> {
  final FocusNode _rootFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  bool _autoRotate = true;
  String _defaultQuality = '720p';
  String _defaultSubtitle = 'OFF';
  String _defaultAudio = 'Indonesian';
  ServerStatus? _serverStatus;
  Timer? _statusCheckTimer;
  int _selectedIndex = 0;
  late List<AccountMenuItem> _menuItems;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    WidgetsBinding.instance.addPostFrameCallback((_) => _rootFocus.requestFocus());
    _startServerStatusCheck();
  }

  @override
  void dispose() {
    _rootFocus.dispose();
    _scrollController.dispose();
    _statusCheckTimer?.cancel();
    super.dispose();
  }

  void _loadMenuItems() {
    _menuItems = [
      AccountMenuItem(label: 'AUTO ROTATE VIDEO', type: MenuItemType.toggle, value: _autoRotate, onToggle: (val) => _saveSetting('auto_rotate', val, () => setState(() => _autoRotate = val))),
      AccountMenuItem(label: 'DEFAULT QUALITY', type: MenuItemType.dropdown, value: _defaultQuality, options: ['Auto', '360p', '480p', '560p', '720p', '1080p'], onSelect: (val) => _saveSetting('default_quality', val, () => setState(() => _defaultQuality = val))),
      AccountMenuItem(label: 'DEFAULT SUBTITLE', type: MenuItemType.dropdown, value: _defaultSubtitle, options: ['OFF', 'English', 'Indonesian', 'Arabic', 'Thai'], onSelect: (val) => _saveSetting('default_subtitle', val, () => setState(() => _defaultSubtitle = val))),
      AccountMenuItem(label: 'DEFAULT AUDIO', type: MenuItemType.dropdown, value: _defaultAudio, options: ['Indonesian', 'English', 'Thai', 'Arabic'], onSelect: (val) => _saveSetting('default_audio', val, () => setState(() => _defaultAudio = val))),
      AccountMenuItem(label: 'CACHE SIZE', type: MenuItemType.info, value: '245 MB'),
      AccountMenuItem(label: 'CLEAR CACHE', type: MenuItemType.button, onTap: () => _clearCache()),
      AccountMenuItem(label: 'ABOUT', type: MenuItemType.info, value: 'LiveGO TV v5.0.0'),
      AccountMenuItem(label: 'LOGOUT', type: MenuItemType.button, onTap: () => _logout()),
    ];
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _autoRotate = prefs.getBool('auto_rotate') ?? true;
      _defaultQuality = prefs.getString('default_quality') ?? '720p';
      _defaultSubtitle = prefs.getString('default_subtitle') ?? 'OFF';
      _defaultAudio = prefs.getString('default_audio') ?? 'Indonesian';
    });
    _loadMenuItems();
  }

  Future<void> _saveSetting(String key, dynamic value, VoidCallback u) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) await prefs.setBool(key, value);
    else if (value is String) await prefs.setString(key, value);
    u();
    _loadMenuItems();
  }

  void _startServerStatusCheck() {
    _checkServerStatus();
    _statusCheckTimer = Timer.periodic(const Duration(seconds: 30), (_) => _checkServerStatus());
  }

  Future<void> _checkServerStatus() async {
    final s = await ApiService.checkServerStatus();
    if (mounted) setState(() => _serverStatus = s);
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('Hapus Cache', style: TextStyle(color: Colors.white)),
        content: const Text('Yakin ingin menghapus semua cache?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('BATAL', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () async {
              await ApiService.clearAllCache();
              Navigator.pop(ctx);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache berhasil dibersihkan'), backgroundColor: Color(0xFF06B6D4)),
                );
              }
            },
            child: const Text('HAPUS', style: TextStyle(color: Color(0xFF06B6D4))),
          ),
        ],
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('Keluar', style: TextStyle(color: Colors.white)),
        content: const Text('Yakin ingin keluar?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('BATAL', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('KELUAR', style: TextStyle(color: Color(0xFF06B6D4))),
          ),
        ],
      ),
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
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              SystemNavigator.pop();
            },
            child: const Text('KELUAR', style: TextStyle(color: Color(0xFF06B6D4))),
          ),
        ],
      ),
    );
  }

  void _showDropdownMenu(AccountMenuItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: Text(item.label, style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: item.options!.map((o) => ListTile(
            title: Text(o, style: const TextStyle(color: Colors.white)),
            trailing: item.value == o ? const Icon(Icons.check, color: Color(0xFF06B6D4)) : null,
            onTap: () {
              item.onSelect?.call(o);
              Navigator.pop(ctx);
              _loadMenuItems();
              setState(() {});
            },
          )).toList(),
        ),
      ),
    );
  }

  void _scrollToIndex(int i) {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      (i * 72.0).clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
    );
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final k = event.logicalKey;

    if (k == LogicalKeyboardKey.escape || k == LogicalKeyboardKey.goBack) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        _showExitDialog();
      }
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.arrowUp && _selectedIndex > 0) {
      setState(() => _selectedIndex--);
      _scrollToIndex(_selectedIndex);
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.arrowDown && _selectedIndex < _menuItems.length - 1) {
      setState(() => _selectedIndex++);
      _scrollToIndex(_selectedIndex);
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.enter || k == LogicalKeyboardKey.select) {
      final item = _menuItems[_selectedIndex];
      if (item.type == MenuItemType.button) item.onTap?.call();
      else if (item.type == MenuItemType.dropdown && item.options != null) _showDropdownMenu(item);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Color _sc() {
    if (_serverStatus == null) return Colors.grey;
    switch (_serverStatus!.colorLabel) {
      case 'green': return const Color(0xFF22C55E);
      case 'yellow': return const Color(0xFFF97316);
      default: return Colors.red;
    }
  }

  IconData _si() {
    if (_serverStatus == null) return Icons.cloud_queue;
    switch (_serverStatus!.colorLabel) {
      case 'green': return Icons.cloud_done;
      case 'yellow': return Icons.warning;
      default: return Icons.cloud_off;
    }
  }

  String _ft(DateTime t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      body: Focus(
        focusNode: _rootFocus,
        autofocus: true,
        onKeyEvent: _onKey,
        child: Column(
          children: [
            _buildHeader(),
            _buildServerStatusBar(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _menuItems.length,
                itemBuilder: (_, i) => RepaintBoundary(
                  child: _OptimizedAccountMenuItem(
                    item: _menuItems[i],
                    isFocused: _selectedIndex == i,
                    onTap: () {
                      setState(() => _selectedIndex = i);
                      final item = _menuItems[i];
                      if (item.type == MenuItemType.button) item.onTap?.call();
                      else if (item.type == MenuItemType.dropdown && item.options != null) _showDropdownMenu(item);
                    },
                  ),
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
    color: const Color(0xFF161B26),
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('PENGATURAN', style: TextStyle(color: Color(0xFF06B6D4), fontSize: 24, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF1A2232), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.close, color: Colors.white70, size: 20),
          ),
        ),
      ],
    ),
  );

  Widget _buildServerStatusBar() {
    final c = _sc();
    final t = _serverStatus?.statusText ?? 'Checking...';
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2232),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle, boxShadow: [BoxShadow(color: c.withOpacity(0.6), blurRadius: 6)])),
          const SizedBox(width: 12),
          Icon(_si(), color: c, size: 18),
          const SizedBox(width: 8),
          Text(t, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 13)),
          const Spacer(),
          Text(_serverStatus != null ? _ft(_serverStatus!.checkedAt) : '--:--:--', style: const TextStyle(color: Colors.white38, fontSize: 11)),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _checkServerStatus,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: const Color(0xFF1A2232), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.refresh, color: Colors.white70, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() => Container(
    color: const Color(0xFF161B26),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white24),
        const SizedBox(height: 8),
        Text('LiveGO TV • Version 5.0.0', style: TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 4),
        Text('© 2025 LiveGO Streaming', style: TextStyle(color: Colors.white24, fontSize: 10)),
      ],
    ),
  );
}

enum MenuItemType { toggle, dropdown, info, button }

class AccountMenuItem {
  final String label;
  final MenuItemType type;
  final dynamic value;
  final List<String>? options;
  final ValueChanged<bool>? onToggle;
  final ValueChanged<String>? onSelect;
  final VoidCallback? onTap;

  AccountMenuItem({
    required this.label,
    required this.type,
    this.value,
    this.options,
    this.onToggle,
    this.onSelect,
    this.onTap,
  });
}

class _OptimizedAccountMenuItem extends StatelessWidget {
  final AccountMenuItem item;
  final bool isFocused;
  final VoidCallback onTap;

  const _OptimizedAccountMenuItem({
    required this.item,
    required this.isFocused,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.03 : 1.0),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isFocused ? const Color(0xFF06B6D4) : const Color(0xFF1A2232),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isFocused ? Colors.white : Colors.white10, width: isFocused ? 2 : 1),
          boxShadow: isFocused ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.3), blurRadius: 12)] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.label, style: TextStyle(color: isFocused ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            _buildValue(),
          ],
        ),
      ),
    );
  }

  Widget _buildValue() {
    switch (item.type) {
      case MenuItemType.toggle:
        return Switch(
          value: item.value ?? false,
          activeColor: isFocused ? Colors.black : const Color(0xFF06B6D4),
          onChanged: (v) => item.onToggle?.call(v),
        );
      case MenuItemType.dropdown:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isFocused ? Colors.black.withOpacity(0.2) : Colors.white10,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(item.value?.toString() ?? 'Select', style: TextStyle(color: isFocused ? Colors.black : Colors.white70, fontSize: 13)),
              const SizedBox(width: 6),
              Icon(Icons.arrow_drop_down, color: isFocused ? Colors.black : Colors.white70, size: 18),
            ],
          ),
        );
      case MenuItemType.info:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isFocused ? Colors.black.withOpacity(0.2) : Colors.white10,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(item.value?.toString() ?? 'N/A', style: TextStyle(color: isFocused ? Colors.black : Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
        );
      case MenuItemType.button:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: isFocused ? Colors.black.withOpacity(0.2) : Colors.white10,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isFocused ? Colors.black12 : Colors.white24),
          ),
          child: Text('PRESS', style: TextStyle(color: isFocused ? Colors.black : const Color(0xFF06B6D4), fontSize: 11, fontWeight: FontWeight.bold)),
        );
    }
  }
}
