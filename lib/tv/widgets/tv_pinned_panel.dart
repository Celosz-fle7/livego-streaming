import 'package:flutter/material.dart';

class TVPinnedPanel
    extends StatelessWidget {
  final int total;

  const TVPinnedPanel({
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
            Icons.push_pin,
            color: Colors.amber,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Pinned',
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
