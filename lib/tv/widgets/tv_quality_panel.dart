import 'package:flutter/material.dart';

class TVQualityPanel
    extends StatelessWidget {
  final String quality;

  const TVQualityPanel({
    super.key,
    required this.quality,
  });

  @override
 Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.high_quality,
            color: Colors.green,
            size: 40,
          ),
          const SizedBox(height: 14),
          Text(
            quality,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
