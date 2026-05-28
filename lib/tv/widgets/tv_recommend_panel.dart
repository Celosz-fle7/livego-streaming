import 'package:flutter/material.dart';

class TVRecommendPanel
    extends StatelessWidget {
  final int total;

  const TVRecommendPanel({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Colors.purple,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Recommended',
            style: const TextStyle(
              color: Colors.white,
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
