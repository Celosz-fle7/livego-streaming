import 'package:flutter/material.dart';

class TVStorageCleanerPanel
    extends StatelessWidget {
  final int cleaned;

  const TVStorageCleanerPanel({
    super.key,
    required this.cleaned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.delete_sweep,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$cleaned MB Cleaned',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
