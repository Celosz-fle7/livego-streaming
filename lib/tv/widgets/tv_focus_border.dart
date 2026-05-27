import 'package:flutter/material.dart';

class TVFocusBorder extends StatelessWidget {
  final bool focused;
  final Widget child;

  const TVFocusBorder({
    super.key,
    required this.focused,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: focused
              ? const Color(0xFF04D2FF)
              : Colors.transparent,
          width: 2.4,
        ),
        boxShadow: focused
            ? [
                const BoxShadow(
                  color: Color(0x6604D2FF),
                  blurRadius: 18,
                )
              ]
            : null,
      ),
      child: child,
    );
  }
}
