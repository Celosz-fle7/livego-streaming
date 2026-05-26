// lib/tv/screens/settings_screen.dart
// LIVEGO TV - SETTINGS SCREEN FIXED

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'source_manager_screen.dart';

class TVSettingsScreen extends StatefulWidget {
  const TVSettingsScreen({super.key});
  @override
  State<TVSettingsScreen> createState() => _TVSettingsScreenState();
}

class _TVSettingsScreenState extends State<TVSettingsScreen> {
  final FocusNode _focusNode = FocusNode();

  String _selectedInterface = 'Otomatis';
  int _gridColumns = 6;
  int _focusedItem = 0;
  static const int _totalItems = 7;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() {
      _selectedInterface = prefs.getString('display_mode') ?? 'Otomatis';
      _gridColumns = (prefs.getInt('tv_grid_columns') ?? 6).clamp(4, 10);
    });
  }

  Future<void> _saveDisplayMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('display_mode', mode);
    if (mounted) setState(() => _selectedInterface = mode);
  }

  Future<void> _saveGridColumns(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final clamped = value.clamp(4, 10);
    await prefs.setInt('tv_grid_columns', clamped);
    if (mounted) setState(() => _gridColumns = clamped);
  }

  Future<void> _clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('cache_') || k.startsWith('time_')).toList();
    for (var key in keys) { await prefs.remove(key); }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache berhasil dibersihkan'), backgroundColor: Color(0xFF06B6D4)),
      );
    }
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

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape || key == LogicalKeyboardKey.goBack) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        _showExitDialog();
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) { setState(() => _focusedItem = (_focusedItem + 1) % _totalItems); return KeyEventResult.handled; }
    if (key == LogicalKeyboardKey.arrowUp) { setState(() => _focusedItem = (_focusedItem - 1 + _totalItems) % _totalItems); return KeyEventResult.handled; }
    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.select) {
      switch (_focusedItem) {
        case 0: _saveDisplayMode('Otomatis'); break;
        case 1: _saveDisplayMode('Mobile'); break;
        case 2: _saveDisplayMode('TV'); break;
        case 3: _saveGridColumns(_gridColumns - 1); break;
        case 4: _saveGridColumns(_gridColumns + 1); break;
        case 5: Navigator.push(context, MaterialPageRoute(builder: (_) => const TVSourceManagerScreen())).then((_) => _focusNode.requestFocus()); break;
        case 6: _clearCache(); break;
      }
      return KeyEventResult.handled;
    }
    if (_focusedItem == 3 || _focusedItem == 4) {
      if (key == LogicalKeyboardKey.arrowLeft) { _saveGridColumns(_gridColumns - 1); return KeyEventResult.handled; }
      if (key == LogicalKeyboardKey.arrowRight) { _saveGridColumns(_gridColumns + 1); return KeyEventResult.handled; }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D111A),
      body: Focus(focusNode: _focusNode, autofocus: true, onKeyEvent: _handleKey,
        child: RepaintBoundary(
          child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('TAMPILAN & NAVIGASI', style: TextStyle(color: Color(0xFF06B6D4), fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(decoration: BoxDecoration(color: const Color(0xFF1F2937), borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  _RadioTile(title: 'Otomatis', subtitle: 'Ikuti hardware', isSelected: _selectedInterface == 'Otomatis', isFocused: _focusedItem == 0, onTap: () => _saveDisplayMode('Otomatis')),
                  _RadioTile(title: 'Mobile', subtitle: 'Smartphone / Tablet', isSelected: _selectedInterface == 'Mobile', isFocused: _focusedItem == 1, onTap: () => _saveDisplayMode('Mobile')),
                  _RadioTile(title: 'TV', subtitle: 'Android TV', isSelected: _selectedInterface == 'TV', isFocused: _focusedItem == 2, onTap: () => _saveDisplayMode('TV')),
                ])),
              const SizedBox(height: 24),
              const Text('JUMLAH KOLOM GRID', style: TextStyle(color: Color(0xFF06B6D4), fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1F2937), borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  _GridBtn(icon: Icons.remove, isFocused: _focusedItem == 3, onTap: () => _saveGridColumns(_gridColumns - 1)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(children: [
                    Text('$_gridColumns kolom', style: const TextStyle(color: Color(0xFF06B6D4), fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('Min 4 — Max 10', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  ])),
                  const SizedBox(width: 12),
                  _GridBtn(icon: Icons.add, isFocused: _focusedItem == 4, onTap: () => _saveGridColumns(_gridColumns + 1)),
                ])),
              const SizedBox(height: 24),
              const Text('SUMBER DATA', style: TextStyle(color: Color(0xFF06B6D4), fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _ActionTile(icon: Icons.dashboard_customize, title: 'Kelola Sumber Data', subtitle: 'Platform & kategori', isFocused: _focusedItem == 5, iconColor: const Color(0xFF06B6D4),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TVSourceManagerScreen())).then((_) => _focusNode.requestFocus())),
              const SizedBox(height: 24),
              const Text('PERAWATAN', style: TextStyle(color: Color(0xFF06B6D4), fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _ActionTile(icon: Icons.delete_outline, title: 'Hapus Semua Cache', subtitle: 'Bersihkan cache', isFocused: _focusedItem == 6, iconColor: Colors.redAccent, onTap: _clearCache),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ),
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String title, subtitle;
  final bool isSelected, isFocused;
  final VoidCallback onTap;
  const _RadioTile({required this.title, required this.subtitle, required this.isSelected, required this.isFocused, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: AnimatedContainer(duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.02 : 1.0),
        decoration: BoxDecoration(color: isFocused ? const Color(0xFF06B6D4).withOpacity(0.15) : Colors.transparent,
          border: isFocused ? const Border(left: BorderSide(color: Color(0xFF06B6D4), width: 3)) : null),
        child: ListTile(
          title: Text(title, style: TextStyle(color: isFocused ? const Color(0xFF06B6D4) : Colors.white, fontWeight: isFocused ? FontWeight.bold : FontWeight.normal)),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38)),
          trailing: Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? const Color(0xFF06B6D4) : Colors.white30),
        )));
  }
}

class _GridBtn extends StatelessWidget {
  final IconData icon;
  final bool isFocused;
  final VoidCallback onTap;
  const _GridBtn({required this.icon, required this.isFocused, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: AnimatedContainer(duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.1 : 1.0),
        width: 48, height: 48,
        decoration: BoxDecoration(color: isFocused ? const Color(0xFF06B6D4) : const Color(0xFF374151), borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isFocused ? Colors.white : Colors.white10),
          boxShadow: isFocused ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.4), blurRadius: 10)] : null),
        child: Icon(icon, color: isFocused ? Colors.black : Colors.white70)));
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final bool isFocused;
  final Color iconColor;
  final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.title, required this.subtitle, required this.isFocused, required this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: AnimatedContainer(duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.02 : 1.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: isFocused ? const Color(0xFF06B6D4).withOpacity(0.1) : const Color(0xFF1F2937), borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isFocused ? const Color(0xFF06B6D4) : Colors.transparent, width: 2),
          boxShadow: isFocused ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.2), blurRadius: 12)] : null),
        child: Row(children: [
          Icon(icon, color: isFocused ? const Color(0xFF06B6D4) : iconColor), const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: isFocused ? const Color(0xFF06B6D4) : Colors.white, fontSize: 16, fontWeight: isFocused ? FontWeight.bold : FontWeight.normal)),
            Text(subtitle, style: const TextStyle(color: Colors.white38)),
          ])),
          Icon(Icons.arrow_forward_ios, color: isFocused ? const Color(0xFF06B6D4) : Colors.white38, size: 16),
        ])));
  }
}
