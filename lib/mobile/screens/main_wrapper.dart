// lib/mobile/screens/main_wrapper.dart
// OPTIMIZED WITH REPAINTBOUNDARY FOR SMOOTH TAB NAVIGATION
// Satu Scaffold + satu BottomNav di sini
// Dialog keluar ala CineFlow: "Sudah selesai nontonnya?"

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'search_screen.dart';
import 'download_screen.dart';
import 'account_screen.dart';
import '../../utils/theme.dart';
import '../../widgets/logo.dart';

class MobileMainWrapper extends StatefulWidget {
  const MobileMainWrapper({super.key});
  @override
  State<MobileMainWrapper> createState() => _MobileMainWrapperState();
}

class _MobileMainWrapperState extends State<MobileMainWrapper> {
  int _navIndex = 0;

  // Halaman disimpan supaya state tidak reset saat ganti tab
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Inisialisasi halaman dengan RepaintBoundary
    _pages = [
      RepaintBoundary(child: const MobileHomeScreen()),
      RepaintBoundary(child: const HistoryScreen()),
      RepaintBoundary(child: const SearchScreen()),
      RepaintBoundary(child: const DownloadScreen()),
      RepaintBoundary(child: const AccountScreen()),
    ];
  }

  // Dialog keluar ala CineFlow
  Future<bool> _showExitDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: RepaintBoundary(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
            decoration: BoxDecoration(
              color: const Color(0xFF161B26),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge konfirmasi
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: LiveGOCopilotTheme.cyan.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: LiveGOCopilotTheme.cyan.withOpacity(0.4)),
                  ),
                  child: Text(
                    'Konfirmasi',
                    style: TextStyle(
                      color: LiveGOCopilotTheme.cyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sudah selesai\nnontonnya?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Yakin mau keluar dari LiveGO sekarang?',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 28),
                // Tombol aksi
                Row(children: [
                  // Nanti Dulu
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                        ),
                        child: const Center(
                          child: Text(
                            'Nanti Dulu',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Ya, Keluar
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4FC3F7), Color(0xFF7B61FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4FC3F7).withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Ya, Keluar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (_navIndex != 0) {
          // Kalau bukan di HOME, kembali ke HOME dulu
          setState(() => _navIndex = 0);
          return;
        }
        final shouldExit = await _showExitDialog();
        if (shouldExit && mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: LiveGOCopilotTheme.background,
        // IndexedStack: semua halaman tetap di memory, state tidak hilang
        body: IndexedStack(
          index: _navIndex,
          children: _pages,
        ),
        bottomNavigationBar: RepaintBoundary(
          child: Container(
            decoration: BoxDecoration(
              color: LiveGOCopilotTheme.surface,
              border: const Border(top: BorderSide(color: Color(0xFF21262D), width: 1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: BottomNavigationBar(
                currentIndex: _navIndex,
                onTap: (i) => setState(() => _navIndex = i),
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: LiveGOCopilotTheme.cyan,
                unselectedItemColor: LiveGOCopilotTheme.textMuted,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded),
                    label: 'HISTORY',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: 'SEARCH',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.download_rounded),
                    label: 'DOWNLOAD',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'AKUN',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
