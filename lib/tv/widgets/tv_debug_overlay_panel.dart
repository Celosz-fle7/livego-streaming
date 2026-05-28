import 'package:flutter/material.dart';

class TVDebugOverlayPanel
    extends StatelessWidget {

  final int fps;

  final int memory;

  const TVDebugOverlayPanel({
    super.key,
    required this.fps,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      right: 20,
      top: 20,

      child: Container(
        padding:
            const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius:
              BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'FPS: $fps',
              style: const TextStyle(
                color: Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'RAM: $memory MB',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
