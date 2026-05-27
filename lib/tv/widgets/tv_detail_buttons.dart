import 'package:flutter/material.dart';

import 'tv_hero_action_button.dart';

class TVDetailButtons
    extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onTrailer;

  const TVDetailButtons({
    super.key,
    required this.onPlay,
    required this.onTrailer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TVHeroActionButton(
          text: 'Tonton',
          icon: Icons.play_arrow,
          primary: true,
          onTap: onPlay,
        ),
        const SizedBox(width: 16),
        TVHeroActionButton(
          text: 'Trailer',
          icon: Icons.movie_filter,
          onTap: onTrailer,
        ),
      ],
    );
  }
}
