// lib/mobile/screens/account_screen.dart
// OPTIMIZED WITH REPAINTBOUNDARY FOR SMOOTH SCROLLING

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mobile_app.dart';
import 'settings_screen.dart';
import 'history_screen.dart';
import 'favorite_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D14),
      body: Stack(
        children: [
          // Background gradient header
          Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFF090D14)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: RepaintBoundary(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    
                    // User Banner
                    RepaintBoundary(child: _buildUserBanner()),
                    const SizedBox(height: 24),
                    
                    // KOLEKSI CEPAT Section
                    RepaintBoundary(
                      child: _buildSection(
                        title: 'KOLEKSI CEPAT',
                        child: _buildMenuGroup([
                          _OptimizedMenuItem(
                            icon: Icons.history,
                            title: 'Riwayat',
                            subtitle: 'Lanjutkan dari tontonan terakhir.',
                            iconColor: null,
                            onTap: () => context.navigateToHistory(),
                          ),
                          _OptimizedMenuItem(
                            icon: Icons.favorite_border,
                            title: 'Favorit',
                            subtitle: 'Buka daftar judul yang Anda simpan.',
                            iconColor: null,
                            onTap: () => context.navigateToFavorite(),
                          ),
                          _OptimizedMenuItem(
                            icon: Icons.settings_outlined,
                            title: 'Pengaturan',
                            subtitle: 'Atur tampilan, player, dan source aktif.',
                            iconColor: null,
                            onTap: () => context.navigateToSettings(),
                            isLast: true,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // APLIKASI & DUKUNGAN Section
                    RepaintBoundary(
                      child: _buildSection(
                        title: 'APLIKASI & DUKUNGAN',
                        child: _buildMenuGroup([
                          _OptimizedMenuItem(
                            icon: Icons.download_for_offline_outlined,
                            title: 'Periksa Pembaruan',
                            subtitle: 'Cek versi terbaru aplikasi.',
                            iconColor: null,
                            onTap: () async {
                              final Uri url = Uri.parse('https://github.com/Celosz-fle7/livego_streaming/releases');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                          ),
                          _OptimizedMenuItem(
                            icon: Icons.share_outlined,
                            title: 'Dukung LiveGO',
                            subtitle: 'Bantu maintenance dan pengembangan aplikasi.',
                            iconColor: null,
                            onTap: () async {
                              final Uri url = Uri.parse('https://github.com/Celosz-fle7/livego_streaming');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                          ),
                          _OptimizedMenuItem(
                            icon: Icons.send_outlined,
                            title: 'Kirim Feedback',
                            subtitle: 'Laporkan bug atau usulkan fitur baru.',
                            iconColor: null,
                            onTap: () async {
                              final Uri url = Uri.parse('mailto:ashtertimur@gmail.com?subject=Feedback%20LiveGO');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                          ),
                          _OptimizedMenuItem(
                            icon: Icons.help_outline,
                            title: 'Bantuan',
                            subtitle: 'Panduan bantuan singkat untuk fitur utama.',
                            iconColor: null,
                            onTap: () => _showHelpDialog(),
                            isLast: true,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // PERAWATAN Section
                    RepaintBoundary(
                      child: _buildSection(
                        title: 'PERAWATAN',
                        child: _buildMenuGroup([
                          _OptimizedMenuItem(
                            icon: Icons.delete_outline,
                            title: 'Hapus Semua Cache',
                            subtitle: 'Bersihkan cache streaming dan gambar.',
                            iconColor: Colors.redAccent,
                            onTap: _clearCache,
                            isLast: true,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white60,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildUserBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131926),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.5), width: 1.5),
                  color: Colors.deepPurple.shade900,
                ),
                child: const Center(
                  child: Icon(Icons.play_arrow_rounded, color: Color(0xFF06B6D4), size: 30),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF06B6D4).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'RUANG PRIBADI',
                        style: TextStyle(color: Color(0xFF06B6D4), fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Akun LiveGO', style: TextStyle(color: Colors.white38, fontSize: 11)),
                    const Text(
                      'User Penggemar',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Masuk cepat ke riwayat, favorit, pengaturan, dan update tanpa harus bolak-balik layar.',
            style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131926),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(children: children),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('Bantuan LiveGO', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Navigasi:\n'
          '• HOME: Lihat daftar drama trending/populer\n'
          '• HISTORY: Riwayat tontonan Anda\n'
          '• SEARCH: Cari drama\n'
          '• DOWNLOAD: Unduhan offline\n'
          '• AKUN: Pengaturan & profil\n\n'
          'Player:\n'
          '• Klik poster untuk play\n'
          '• Double tap kiri/kanan untuk seek 10 detik\n'
          '• Klik fullscreen untuk landscape',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup', style: TextStyle(color: Color(0xFF06B6D4))),
          ),
        ],
      ),
    );
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
}

// ============================================================
// OPTIMIZED MENU ITEM - Separate widget with RepaintBoundary
// ============================================================
class _OptimizedMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? iconColor;
  final VoidCallback onTap;
  final bool isLast;

  const _OptimizedMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF1C2436),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? Colors.white70, size: 22),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 16),
            onTap: onTap,
          ),
          if (!isLast) const Divider(color: Colors.white10, height: 1, indent: 16, endIndent: 16),
        ],
      ),
    );
  }
}
