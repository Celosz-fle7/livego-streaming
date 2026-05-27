import 'package:flutter/material.dart';

class TVStreamQualityPanel
    extends StatelessWidget {
  final String quality;
  final int bitrate;

  const TVStreamQualityPanel({
    super.key,
    required this.quality,
    required this.bitrate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.hd,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            quality,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$bitrate kbps',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
