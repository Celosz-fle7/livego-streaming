import 'package:flutter/material.dart';

class TVNetworkAdaptivePanel extends StatelessWidget {
  final String mode;
  final int bandwidth;
  final bool metered;

  const TVNetworkAdaptivePanel({
    super.key,
    required this.mode,
    required this.bandwidth,
    required this.metered,
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
          const Icon(Icons.network_check, color: Colors.green, size: 72),
          const SizedBox(height: 20),
          Text(
            mode,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$bandwidth Mbps • ${metered ? "Metered" : "Unlimited"}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
