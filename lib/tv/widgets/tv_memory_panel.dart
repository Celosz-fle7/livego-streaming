import 'package:flutter/material.dart';

class TVMemoryPanel
    extends StatelessWidget {
  final double used;
  final double total;

  const TVMemoryPanel({
    super.key,
    required this.used,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent =
        (used / total).clamp(0.0, 1.0);

    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Memory Usage',
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor:
                Colors.white24,
            valueColor:
                const AlwaysStoppedAnimation(
              Color(0xFF04D2FF),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${used.toStringAsFixed(1)} GB / ${total.toStringAsFixed(1)} GB',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
