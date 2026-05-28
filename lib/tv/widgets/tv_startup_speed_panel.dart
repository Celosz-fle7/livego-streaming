import 'package:flutter/material.dart';

class TVStartupSpeedPanel extends StatelessWidget {
  final bool preloadHome;
  final bool preloadImages;
  final int bootDelay;

  const TVStartupSpeedPanel({
    super.key,
    required this.preloadHome,
    required this.preloadImages,
    required this.bootDelay,
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
          const Icon(Icons.flash_on, color: Colors.orange, size: 72),
          const SizedBox(height: 20),
          Text(
            '${bootDelay}ms',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Home ${preloadHome ? "ON" : "OFF"} • Images ${preloadImages ? "ON" : "OFF"}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
