import 'package:flutter/material.dart';

class TVPlayerBottomHUD
    extends StatelessWidget {
  final double position;
  final double duration;
  final String Function(double) format;

  const TVPlayerBottomHUD({
    super.key,
    required this.position,
    required this.duration,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: duration <= 0
              ? 0
              : position / duration,
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
              MainAxisAlignment
                  .spaceBetween,
          children: [
            Text(
              format(position),
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            Text(
              format(duration),
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
