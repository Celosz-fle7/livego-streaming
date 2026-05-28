import 'package:flutter/material.dart';

class TVEpisodeMemoryPanel
    extends StatelessWidget {
  final int episode;

  const TVEpisodeMemoryPanel({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.play_circle,
            color: Colors.cyan,
            size: 40,
          ),
          const SizedBox(height: 14),
          Text(
            'Episode $episode',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
