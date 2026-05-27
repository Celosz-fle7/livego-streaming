import 'package:flutter/material.dart';

import 'tv_episode_chip.dart';

class TVEpisodeGrid
    extends StatelessWidget {
  final List<int> episodes;
  final int currentEpisode;
  final Function(int ep) onSelect;

  const TVEpisodeGrid({
    super.key,
    required this.episodes,
    required this.currentEpisode,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.25,
      ),
      itemCount: episodes.length,
      itemBuilder: (_, i) {
        final ep = episodes[i];

        return GestureDetector(
          onTap: () => onSelect(ep),
          child: TVEpisodeChip(
            episode: ep,
            selected:
                ep == currentEpisode,
            focused: false,
          ),
        );
      },
    );
  }
}
