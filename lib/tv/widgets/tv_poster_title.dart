import 'package:flutter/material.dart';

class TVPosterTitle extends StatelessWidget {
  final String title;
  final bool focused;

  const TVPosterTitle({
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
            ? Colors.white
            : Colors.white70,
        fontSize: focused ? 14 : 13,
        fontWeight: focused
            ? FontWeight.bold
            : FontWeight.w500,
      ),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
