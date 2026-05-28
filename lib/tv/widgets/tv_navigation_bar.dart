import 'package:flutter/material.dart';

class TVNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onSelect;

  const TVNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      'Home',
      'Live TV',
      'Sports',
      'Search',
      'System',
      'Profile',
      'Settings',
    ];

    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border(
          bottom: BorderSide(color: Colors.white10),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) {
          final active = i == currentIndex;

          return GestureDetector(
            onTap: () => onSelect(i),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF04D2FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                items[i],
                style: TextStyle(
                  color: active ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
