import 'package:flutter/material.dart';

class TVSmartDownloadPanel
    extends StatelessWidget {
  final int active;
  final int completed;

  const TVSmartDownloadPanel({
    super.key,
    required this.active,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            '$active Active',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$completed Completed',
            style: const TextStyle(
              color: Colors.green,
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
