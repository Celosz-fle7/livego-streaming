import 'package:flutter/material.dart';

class TVLiveLatencyPanel
    extends StatelessWidget {
  final double latency;

  const TVLiveLatencyPanel({
    super.key,
    required this.latency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.speed,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '${latency.toStringAsFixed(1)}s',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
