import 'package:flutter/material.dart';

class TVStatsPanel
    extends StatelessWidget {
  final String network;
  final double speed;

  const TVStatsPanel({
    super.key,
    required this.network,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Network: $network',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Speed: ${speed}x',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
