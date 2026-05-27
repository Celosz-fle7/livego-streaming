import 'package:flutter/material.dart';

class TVPlayerPolicyPanel extends StatelessWidget {
  final String quality;
  final int bitrate;
  final bool preload;

  const TVPlayerPolicyPanel({
    super.key,
    required this.quality,
    required this.bitrate,
    required this.preload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.play_circle, color: Colors.green, size: 72),
          const SizedBox(height: 20),
          Text(
            quality,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$bitrate kbps • Preload ${preload ? "ON" : "OFF"}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
