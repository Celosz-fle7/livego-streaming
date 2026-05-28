import 'package:flutter/material.dart';

class TVSystemHealthPanel
    extends StatelessWidget {

  final int fps;
  final int memory;
  final bool healthy;

  const TVSystemHealthPanel({
    super.key,
    required this.fps,
    required this.memory,
    required this.healthy,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            healthy
                ? Icons.health_and_safety
                : Icons.warning,

            color:
                healthy
                    ? Colors.green
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$fps FPS',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '$memory MB',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
