import 'package:flutter/material.dart';

class TVRailTitle extends StatelessWidget {
  final String title;
  final bool focused;

  const TVRailTitle({
    super.key,
    required this.title,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration:
          const Duration(milliseconds: 120),
      style: TextStyle(
        color: focused
            ? const Color(0xFF04D2FF)
            : Colors.white,
        fontSize: focused ? 24 : 22,
        fontWeight: FontWeight.bold,
      ),
      child: Text(title),
    );
  }
}
