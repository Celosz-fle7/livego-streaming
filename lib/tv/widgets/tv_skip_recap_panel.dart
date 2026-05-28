import 'package:flutter/material.dart';

class TVSkipRecapPanel
    extends StatelessWidget {
  final bool enabled;
  final int seconds;

  const TVSkipRecapPanel({
    super.key,
    required this.enabled,
    required this.seconds,
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
          const Icon(
            Icons.skip_next,
            color: Colors.purple,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Skip Recap'
                : 'Show Recap',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$seconds Seconds',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
