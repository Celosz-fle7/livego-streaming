import 'package:flutter/material.dart';

class TVBufferPanel
    extends StatelessWidget {
  final bool buffering;
  final int bufferMs;

  const TVBufferPanel({
    super.key,
    required this.buffering,
    required this.bufferMs,
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
          Icon(
            buffering
                ? Icons.hourglass_bottom
                : Icons.check_circle,
            color:
                buffering ? Colors.orange : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '${bufferMs}ms',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
