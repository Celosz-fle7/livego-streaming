import 'package:flutter/material.dart';

class TVHeroGradient extends StatelessWidget {
  const TVHeroGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withOpacity(0.92),
              Colors.black.withOpacity(0.55),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
