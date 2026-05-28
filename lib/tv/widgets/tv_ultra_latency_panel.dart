import 'package:flutter/material.dart';

class TVUltraLatencyPanel
    extends StatelessWidget {
  final double latency;

  const TVUltraLatencyPanel({
    super.key,
    required this.latency,
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
            Icons.network_ping,
            color: Colors.orange,
            size: 44,
          ),
          const SizedBox(height: 16),
          Text(
            '${latency.toStringAsFixed(1)}ms',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
