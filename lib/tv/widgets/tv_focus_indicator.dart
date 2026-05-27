import 'package:flutter/material.dart';

class TVFocusIndicator
    extends StatelessWidget {
  final bool focused;

  const TVFocusIndicator({
    super.key,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 120),
      height: 4,
      width: focused ? 80 : 0,
      decoration: BoxDecoration(
        color: const Color(0xFF04D2FF),
        borderRadius:
            BorderRadius.circular(20),
      ),
    );
  }
}
