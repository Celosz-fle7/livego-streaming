import 'package:flutter/material.dart';

class TVPlayerStatusBar
    extends StatelessWidget {
  final bool playing;
  final bool buffering;

  const TVPlayerStatusBar({
    super.key,
    required this.playing,
    required this.buffering,
  });

  @override
  Widget build(BuildContext context) {
    String text = 'Paused';

    if (buffering) {
      text = 'Buffering';
    } else if (playing) {
      text = 'Playing';
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
