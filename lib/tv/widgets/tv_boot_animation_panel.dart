import 'package:flutter/material.dart';

class TVBootAnimationPanel
    extends StatelessWidget {
  final bool enabled;
  final int duration;

  const TVBootAnimationPanel({
    super.key,
    required this.enabled,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            Icons.animation,
            color: enabled
                ? Colors.cyan
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Boot Animation'
                : 'No Animation',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$duration Seconds',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
