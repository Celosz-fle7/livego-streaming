import 'package:flutter/material.dart';

class TVCoreXPanel
    extends StatelessWidget {
  final int cores;

  const TVCoreXPanel({
    super.key,
    required this.cores,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.developer_board,
            color: Colors.cyan,
            size: 78,
          ),
          const SizedBox(height: 22),
          Text(
            '$cores Cores',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 46,
            ),
          ),
        ],
      ),
    );
  }
}
