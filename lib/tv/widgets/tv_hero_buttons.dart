import 'package:flutter/material.dart';

import 'tv_hero_action_button.dart';

class TVHeroButtons extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onDetail;

  const TVHeroButtons({
    super.key,
    required this.onPlay,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TVHeroActionButton(
          text: 'Putar',
          icon: Icons.play_arrow,
          onTap: onPlay,
          primary: true,
        ),
        const SizedBox(width: 16),
        TVHeroActionButton(
          text: 'Detail',
          icon: Icons.info_outline,
          onTap: onDetail,
        ),
      ],
    );
  }
}
