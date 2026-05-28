import 'package:flutter/material.dart';

class TVSourceHealthPanel
    extends StatelessWidget {
  final String source;
  final int score;

  const TVSourceHealthPanel({
    super.key,
    required this.source,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            source,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$score%',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
