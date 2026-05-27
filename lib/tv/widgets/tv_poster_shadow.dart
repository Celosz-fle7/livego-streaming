import 'package:flutter/material.dart';

class TVPosterShadow extends StatelessWidget {
  final Widget child;
  final bool focused;

  const TVPosterShadow({
    super.key,
    required this.child,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        boxShadow: focused
            ? [
                BoxShadow(
                  color: const Color(
                    0xFF04D2FF,
                  ).withOpacity(0.45),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
