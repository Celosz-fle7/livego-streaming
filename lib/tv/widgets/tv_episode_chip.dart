import 'package:flutter/material.dart';

class TVEpisodeChip extends StatelessWidget {
  final int episode;
  final bool selected;
  final bool focused;

  const TVEpisodeChip({
    super.key,
    required this.episode,
    required this.selected,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: focused ? 1.08 : 1.0,
      duration:
          const Duration(milliseconds: 120),
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 120),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFF003F)
              : focused
                  ? Colors.white24
                  : Colors.white10,
          borderRadius:
              BorderRadius.circular(10),
          border: Border.all(
            color: focused
                ? const Color(0xFF04D2FF)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          '$episode',
          style: TextStyle(
            color: Colors.white,
            fontWeight: selected ||
                    focused
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
