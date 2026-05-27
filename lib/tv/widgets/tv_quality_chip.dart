import 'package:flutter/material.dart';

class TVQualityChip
    extends StatelessWidget {
  final String quality;

  const TVQualityChip({
    super.key,
    required this.quality,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        quality,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
