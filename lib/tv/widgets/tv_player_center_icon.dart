import 'package:flutter/material.dart';

class TVPlayerCenterIcon
    extends StatelessWidget {
  final bool playing;

  const TVPlayerCenterIcon({
    super.key,
    required this.playing,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      playing
          ? Icons.pause_circle
          : Icons.play_circle,
      color: Colors.white70,
      size: 86,
    );
  }
}
