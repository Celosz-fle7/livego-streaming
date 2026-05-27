import 'package:flutter/material.dart';

class TVAutoFPSPanel
    extends StatelessWidget {
  final bool enabled;
  final int fps;

  const TVAutoFPSPanel({
    super.key,
    required this.enabled,
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
          Icon(
            enabled
                ? Icons.speed
                : Icons.speed_outlined,
            color:
                enabled ? Colors.green : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$fps FPS',
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
