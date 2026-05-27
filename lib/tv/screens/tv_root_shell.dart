import 'package:flutter/material.dart';

import 'home_screen_v2.dart';
import 'live_tv_screen.dart';
import 'profile_screen.dart';
import 'search_screen_v2.dart';
import 'settings_screen.dart';

import '../widgets/tv_navigation_bar.dart';

class TVRootShell
    extends StatefulWidget {
  const TVRootShell({
    super.key,
  });

  @override
  State<TVRootShell> createState() =>
      _TVRootShellState();
}

class _TVRootShellState
    extends State<TVRootShell> {
  int _index = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = const [
      TVHomeScreenV2(),
      LiveTVScreen(),
      TVSearchScreenV2(),
      TVProfileScreen(),
      TVSettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: Column(
        children: [
          TVNavigationBarWidget(
            currentIndex: _index,
            onSelect: (i) {
              setState(() {
                _index = i;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _index,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
