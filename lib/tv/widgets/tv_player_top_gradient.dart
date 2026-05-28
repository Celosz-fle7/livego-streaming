import 'package:flutter/material.dart';

class TVPlayerTopGradient extends StatelessWidget {
  final Widget child;

  const TVPlayerTopGradient({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(
        36,
        34,
        36,
        80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(
              0.88,
            ),
            Colors.transparent,
          ],
        ),
      ),
      child: child,
    );
  }
}
