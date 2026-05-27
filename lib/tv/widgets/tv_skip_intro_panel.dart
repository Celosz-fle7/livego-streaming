import 'package:flutter/material.dart';

class TVSkipIntroPanel
    extends StatelessWidget {
  final bool enabled;
  final int seconds;

  const TVSkipIntroPanel({
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
            Icons.fast_forward,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Skip Intro'
                : 'Manual Intro',
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
