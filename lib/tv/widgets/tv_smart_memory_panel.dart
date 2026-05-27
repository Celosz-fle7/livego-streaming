import 'package:flutter/material.dart';

class TVSmartMemoryPanel
    extends StatelessWidget {
  final int used;
  final int free;

  const TVSmartMemoryPanel({
    super.key,
    required this.used,
    required this.free,
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
            '$used MB Used',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$free MB Free',
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
