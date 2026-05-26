// lib/mobile/screens/settings_screen.dart
// OPTIMIZED WITH REPAINTBOUNDARY FOR SMOOTH SCROLLING

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mobile_app.dart';
import 'source_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedInterface = 'Otomatis';
  bool _showBackgroundPoster = true;
  bool _useCachePlayback = false;
  bool _showRotationButton = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _selectedInterface = prefs.getString('display_mode') ?? 'Otomatis';
        _showBackgroundPoster = prefs.getBool('background_poster') ?? true;
        _useCachePlayback = prefs.getBool('cache_playback') ?? false;
        _showRotationButton = prefs.getBool('manual_rotate') ?? true;
      });
    }
  }

  Future<void> _saveDisplayMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('display_mode', mode);
    if (mounted) setState(() => _selectedInterface = mode);
  }

  Future<void> _saveSwitch(String key, bool value, VoidCallback updateState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    if (mounted) updateState();
  }

  Future<void> _clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith('cache_') || key.startsWith('time_')) {
        await prefs.remove(key);
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cache berhasil dibersihkan'),
          backgroundColor: Color(0xFF06B6D4),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D14),
      appBar: AppBar(
        title: const Text('Pengaturan', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF111622),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RepaintBoundary(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Banner
              RepaintBoundary(child: _buildHeaderBanner()),
              const SizedBox(height: 24),

              // TAMPILAN & NAVIGASI
              RepaintBoundary(
                child: _buildSection(
                  title: 'TAMPILAN & NAVIGASI',
                  child: Column(
                    children: [
                      _OptimizedRadioTile(
                        value: 'Otomatis',
                        groupValue: _selectedInterface,
                        title: 'Otomatis',
                        subtitle: 'Ikuti hardware (lebar layar)',
                        onChanged: (val) => _saveDisplayMode(val!),
                      ),
                      _OptimizedRadioTile(
                        value: 'Mobile',
                        groupValue: _selectedInterface,
                        title: 'Mobile',
                        subtitle: 'Smartphone / Tablet',
                        onChanged: (val) => _saveDisplayMode(val!),
                      ),
                      _OptimizedRadioTile(
                        value: 'TV',
                        groupValue: _selectedInterface,
                        title: 'TV',
                        subtitle: 'Android TV (Leanback Style)',
                        onChanged: (val) => _saveDisplayMode(val!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // PLAYER
              RepaintBoundary(
                child: _buildSection(
                  title: 'PLAYER',
                  child: Column(
                    children: [
                      _OptimizedSwitchTile(
                        title: 'Tampilkan Background Poster',
                        subtitle: 'Tampilkan poster sebagai ambience di player',
                        value: _showBackgroundPoster,
                        onChanged: (val) => _saveSwitch('background_poster', val, () {
                          setState(() => _showBackgroundPoster = val);
                        }),
                      ),
                      _OptimizedSwitchTile(
                        title: 'Gunakan Cache Playback',
                        subtitle: 'Simpan potongan stream sementara',
                        value: _useCachePlayback,
                        onChanged: (val) => _saveSwitch('cache_playback', val, () {
                          setState(() => _useCachePlayback = val);
                        }),
                      ),
                      _OptimizedSwitchTile(
                        title: 'Tampilkan Tombol Rotasi Manual',
                        subtitle: 'Tampilkan kontrol rotasi manual di player',
                        value: _showRotationButton,
                        onChanged: (val) => _saveSwitch('manual_rotate', val, () {
                          setState(() => _showRotationButton = val);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // SUMBER DATA
              RepaintBoundary(
                child: _buildSection(
                  title: 'SUMBER DATA',
                  child: Column(
                    children: [
                      _OptimizedActionTile(
                        icon: Icons.layers_outlined,
                        title: 'Kelola Sumber Data',
                        subtitle: 'Aktifkan platform yang ingin muncul di beranda',
                        iconColor: const Color(0xFF06B6D4),
                        onTap: () {
                          context.navigateToSourceManager();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // PERAWATAN
              RepaintBoundary(
                child: _buildSection(
                  title: 'PERAWATAN',
                  child: Column(
                    children: [
                      _OptimizedActionTile(
                        icon: Icons.delete_outline,
                        title: 'Hapus Semua Cache',
                        subtitle: 'Bersihkan cache streaming dan gambar',
                        iconColor: Colors.redAccent,
                        onTap: _clearCache,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111622),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111622),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CONTROL CENTER',
            style: TextStyle(color: Color(0xFF06B6D4), fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pengaturan LiveGO',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 6),
          const Text(
            'Rapikan mode tampilan, player, source, izin, dan cache dari satu tempat.',
            style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// OPTIMIZED RADIO TILE - Separate widget
// ============================================================
class _OptimizedRadioTile extends StatelessWidget {
  final String value;
  final String groupValue;
  final String title;
  final String subtitle;
  final ValueChanged<String?> onChanged;

  const _OptimizedRadioTile({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: value,
      groupValue: groupValue,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38)),
      activeColor: const Color(0xFF06B6D4),
      onChanged: onChanged,
    );
  }
}

// ============================================================
// OPTIMIZED SWITCH TILE - Separate widget
// ============================================================
class _OptimizedSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _OptimizedSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38)),
      value: value,
      activeColor: const Color(0xFF06B6D4),
      onChanged: onChanged,
    );
  }
}

// ============================================================
// OPTIMIZED ACTION TILE - Separate widget
// ============================================================
class _OptimizedActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const _OptimizedActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white30),
      onTap: onTap,
    );
  }
}
