import 'package:flutter/material.dart';

class TVSingularityPanel
    extends StatelessWidget {
  final int density;

  const TVSingularityPanel({
    super.key,
    required this.density,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.blur_circular,
            color: Colors.deepPurple,
            size: 72,
          ),
          const SizedBox(height: 22),
          Text(
            '$density',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'SINGULARITY CORE',
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
