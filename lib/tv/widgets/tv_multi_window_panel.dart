import 'package:flutter/material.dart';

class TVMultiWindowPanel
    extends StatelessWidget {
  final int windows;

  const TVMultiWindowPanel({
    super.key,
    required this.windows,
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
          const Icon(
            Icons.grid_4x4,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$windows Windows',
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
