import 'package:flutter/material.dart';

class TVSystemHealthPanel
    extends StatelessWidget {
  final int score;
  final bool healthy;

  const TVSystemHealthPanel({
    super.key,
    required this.score,
    required this.healthy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            healthy
                ? Icons.favorite
                : Icons.warning,
            color:
                healthy ? Colors.green : Colors.red,
            size: 52,
          ),
          const SizedBox(height: 18),
          Text(
            '$score%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
