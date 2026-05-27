import 'package:flutter/material.dart';

class TVZenithPanel
    extends StatelessWidget {
  final int altitude;

  const TVZenithPanel({
    super.key,
    required this.altitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.vertical_align_top,
            color: Colors.orange,
            size: 92,
          ),
          const SizedBox(height: 26),
          Text(
            '$altitude',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 54,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ZENITH SYSTEM',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
