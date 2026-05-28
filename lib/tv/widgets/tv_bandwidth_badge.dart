import 'package:flutter/material.dart';

class TVBandwidthBadge
    extends StatelessWidget {
  final String label;

  const TVBandwidthBadge({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    if (label == 'MEDIUM') {
      color = Colors.orange;
    }

    if (label == 'SLOW') {
      color = Colors.red;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
