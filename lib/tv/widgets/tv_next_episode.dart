import 'package:flutter/material.dart';

class TVNextEpisode extends StatelessWidget {
  final int nextEpisode;

  const TVNextEpisode({
    super.key,
    required this.nextEpisode,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 40,
      bottom: 80,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius:
              BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Episode Berikutnya',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Episode $nextEpisode',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
