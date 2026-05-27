import 'package:flutter/material.dart';

class TVCinemaAIPanel
    extends StatelessWidget {
  final int scenes;

  const TVCinemaAIPanel({
    super.key,
    required this.scenes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.movie_filter,
            color: Colors.purple,
            size: 44,
          ),
          const SizedBox(height: 16),
          Text(
            '$scenes Scenes',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
