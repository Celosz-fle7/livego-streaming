import 'package:flutter/material.dart';

class TVSmartFPSPanel
    extends StatelessWidget {
  final int fps;

  const TVSmartFPSPanel({
    super.key,
    required this.fps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.speed,
            color: Colors.green,
            size: 44,
          ),
          const SizedBox(height: 16),
          Text(
            '$fps FPS',
            style: const TextStyle(
              color: Colors.white,
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
