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
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFF04D2FF,
        ),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        quality,
        style: const TextStyle(
          color: Colors.black,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
