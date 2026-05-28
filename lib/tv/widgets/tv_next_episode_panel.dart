import 'package:flutter/material.dart';

class TVNextEpisodePanel
    extends StatelessWidget {
  final int nextEpisode;

  const TVNextEpisodePanel({
    super.key,
    required this.nextEpisode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Episode Berikutnya',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Episode $nextEpisode',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
