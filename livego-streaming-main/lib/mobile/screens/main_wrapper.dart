import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'account_screen.dart';
import 'favorite_screen.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class MobileMainWrapper extends StatefulWidget {
  const MobileMainWrapper({super.key});

  @override
  State<MobileMainWrapper> createState() => _MobileMainWrapperState();
}

class _MobileMainWrapperState extends State<MobileMainWrapper> {
  int _index = 0;

  final _pages = const [
    MobileHomeScreen(),
    HistoryScreen(),
    SearchScreen(),
    FavoriteScreen(),
    AccountScreen(),
  ];

  Future<bool> _confirmExit() async {
    if (_index != 0) {
      setState(() => _index = 0);
      return false;
    }

    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(.72),
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 40,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sudah selesai nontonnya?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Keluar dari LiveGO sekarang?',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Nanti dulu'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Keluar'),
                    ),
                  ),
                ],
              ),
            ],
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
        final exit = await _confirmExit();
        if (exit) SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF05070D),
        body: IndexedStack(
          index: _index,
          children: _pages,
        ),
        bottomNavigationBar: _PremiumBottomNav(
          index: _index,
          onChanged: (value) => setState(() => _index = value),
        ),
      ),
    );
  }
}

class _PremiumBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const _PremiumBottomNav({
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_rounded, 'Home'),
      (Icons.history_rounded, 'Histori'),
      (Icons.search_rounded, 'Search'),
      (Icons.favorite_rounded, 'Favorit'),
      (Icons.person_rounded, 'Akun'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xEE0F1420),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 28,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (i) {
            final active = i == index;
            final item = items[i];
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    gradient: active
                        ? const LinearGradient(
                            colors: [Color(0xFF2DD4FF), Color(0xFF7C3AED)],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.$1,
                        color: active ? Colors.white : Colors.white54,
                        size: 23,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$2,
                        maxLines: 1,
                        style: TextStyle(
                          color: active ? Colors.white : Colors.white54,
                          fontSize: 11,
                          fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
