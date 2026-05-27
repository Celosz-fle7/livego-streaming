import 'package:flutter/material.dart';

class TVPlayerWatermark
    extends StatelessWidget {
  const TVPlayerWatermark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.12,
      child: Container(
        alignment: Alignment.topRight,
        padding:
            const EdgeInsets.all(24),
        child: const Text(
          'DRACIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }
}
