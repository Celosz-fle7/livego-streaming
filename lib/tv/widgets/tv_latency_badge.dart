import 'package:flutter/material.dart';

class TVLatencyBadge
    extends StatelessWidget {
  final int latency;

  const TVLatencyBadge({
    super.key,
    required this.latency,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    if (latency > 40) {
      color = Colors.orange;
    }

    if (latency > 90) {
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
        '${latency}ms',
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
