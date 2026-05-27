import 'package:flutter/material.dart';

class TVPerformanceHUDPanel
    extends StatelessWidget {

  final int fps;
  final int memory;
  final int cpu;

  const TVPerformanceHUDPanel({
    super.key,
    required this.fps,
    required this.memory,
    required this.cpu,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            'PERFORMANCE HUD',
            style: TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'FPS: $fps',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'RAM: $memory MB',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'CPU: $cpu%',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
