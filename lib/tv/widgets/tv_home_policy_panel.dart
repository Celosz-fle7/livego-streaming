import 'package:flutter/material.dart';

class TVHomePolicyPanel extends StatelessWidget {
  final int rails;
  final int items;
  final bool preload;

  const TVHomePolicyPanel({
    super.key,
    required this.rails,
    required this.items,
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
          const Icon(Icons.dashboard, color: Colors.orange, size: 72),
          const SizedBox(height: 20),
          Text(
            '$rails Rails',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$items items/rail • Preload ${preload ? "ON" : "OFF"}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
