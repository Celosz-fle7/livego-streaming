import 'package:flutter/material.dart';

class TVRecentPanel
    extends StatelessWidget {
  final int total;

  const TVRecentPanel({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
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
            Icons.new_releases,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Recent',
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
