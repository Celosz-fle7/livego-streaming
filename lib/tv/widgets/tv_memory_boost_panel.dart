import 'package:flutter/material.dart';

class TVMemoryBoostPanel
    extends StatelessWidget {
  final bool active;
  final int cleared;

  const TVMemoryBoostPanel({
    super.key,
    required this.active,
    required this.cleared,
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
            active
                ? Icons.memory
                : Icons.sd_storage,
            color: active
                ? Colors.green
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$cleared MB Freed',
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
