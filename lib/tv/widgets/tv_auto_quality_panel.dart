import 'package:flutter/material.dart';

class TVAutoQualityPanel extends StatelessWidget {
  final String uiQuality;
  final String imageQuality;
  final bool animations;

  const TVAutoQualityPanel({
    super.key,
    required this.uiQuality,
    required this.imageQuality,
    required this.animations,
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
          const Icon(
            Icons.tune,
            color: Colors.green,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            'UI $uiQuality',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Image $imageQuality • Anim ${animations ? "ON" : "OFF"}',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
