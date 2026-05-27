import 'package:flutter/material.dart';

class TVChronoPanel
    extends StatelessWidget {
  final int timelines;

  const TVChronoPanel({
    super.key,
    required this.timelines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.schedule,
            color: Colors.orange,
            size: 80,
          ),
          const SizedBox(height: 24),
          Text(
            '$timelines Timelines',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
        ],
      ),
    );
  }
}
