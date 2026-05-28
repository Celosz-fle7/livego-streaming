import 'package:flutter/material.dart';

class TVEmperorPanel
    extends StatelessWidget {
  final int empire;

  const TVEmperorPanel({
    super.key,
    required this.empire,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.king_bed,
            color: Colors.amber,
            size: 88,
          ),
          const SizedBox(height: 24),
          Text(
            '$empire',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ],
      ),
    );
  }
}
