import 'package:flutter/material.dart';

class TVNetworkPanel
    extends StatelessWidget {
  final String type;
  final double speed;

  const TVNetworkPanel({
    super.key,
    required this.type,
    required this.speed,
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
            Icons.wifi,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            type,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${speed.toStringAsFixed(1)} Mbps',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
