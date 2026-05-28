import 'package:flutter/material.dart';

class TVPlayerBottomBar
    extends StatelessWidget {
  final double progress;
  final double duration;

  const TVPlayerBottomBar({
    super.key,
    required this.progress,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      right: 30,
      bottom: 28,
      child: Column(
        children: [
          LinearProgressIndicator(
            value: duration <= 0
                ? 0
                : progress / duration,
            minHeight: 6,
            backgroundColor:
                Colors.white24,
            valueColor:
                const AlwaysStoppedAnimation(
              Color(0xFF04D2FF),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${progress.toInt()}s',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                '${duration.toInt()}s',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
