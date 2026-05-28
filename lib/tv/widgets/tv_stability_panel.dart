import 'package:flutter/material.dart';

class TVStabilityPanel
    extends StatelessWidget {

  final bool stable;

  final int optimizations;

  const TVStabilityPanel({
    super.key,
    required this.stable,
    required this.optimizations,
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
            stable
                ? Icons.check_circle
                : Icons.warning,

            color:
                stable
                    ? Colors.green
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$optimizations',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'SYSTEM STABILITY',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
