import 'package:flutter/material.dart';

import 'tv_player_button.dart';

class TVPlayerControlBar
    extends StatelessWidget {
  final bool playing;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const TVPlayerControlBar({
    super.key,
    required this.playing,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        TVPlayerButton(
          icon: Icons.skip_previous,
          focused: false,
          onTap: onPrev,
        ),
        const SizedBox(width: 18),
        TVPlayerButton(
          icon: playing
              ? Icons.pause
              : Icons.play_arrow,
          focused: true,
          onTap: onPlayPause,
          label:
              playing ? 'Pause' : 'Play',
        ),
        const SizedBox(width: 18),
        TVPlayerButton(
          icon: Icons.skip_next,
          focused: false,
          onTap: onNext,
        ),
      ],
    );
  }
}
