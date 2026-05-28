import 'package:flutter/material.dart';

class TVPlayerHUD extends StatelessWidget {
  final String title;
  final int episode;

  const TVPlayerHUD({
    super.key,
    required this.title,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 40,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Episode $episode',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
