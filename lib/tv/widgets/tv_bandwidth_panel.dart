import 'package:flutter/material.dart';

class TVBandwidthPanel
    extends StatelessWidget {
  final double current;
  final double peak;

  const TVBandwidthPanel({
    super.key,
    required this.current,
    required this.peak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            '${current.toStringAsFixed(1)} Mbps',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Peak ${peak.toStringAsFixed(1)} Mbps',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
