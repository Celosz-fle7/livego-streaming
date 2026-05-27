import 'package:flutter/material.dart';

class TVAudioBadge
    extends StatelessWidget {
  final bool muted;

  const TVAudioBadge({
    super.key,
    required this.muted,
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
        color: muted
            ? Colors.red
            : Colors.green,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        muted ? 'MUTED' : 'AUDIO',
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
