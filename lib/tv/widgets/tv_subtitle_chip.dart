import 'package:flutter/material.dart';

class TVSubtitleChip
    extends StatelessWidget {
  final bool enabled;

  const TVSubtitleChip({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: enabled
            ? Colors.white
            : Colors.white12,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        enabled
            ? 'SUB ON'
            : 'SUB OFF',
        style: TextStyle(
          color: enabled
              ? Colors.black
              : Colors.white70,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
