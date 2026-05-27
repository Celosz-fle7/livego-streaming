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
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: enabled
            ? const Color(0xFF04D2FF)
            : Colors.white12,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        enabled ? 'SUB ON' : 'SUB OFF',
        style: TextStyle(
          color: enabled
              ? Colors.black
              : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
