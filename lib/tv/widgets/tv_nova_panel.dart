import 'package:flutter/material.dart';

class TVNovaPanel
    extends StatelessWidget {
  final int bursts;

  const TVNovaPanel({
    super.key,
    required this.bursts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.brightness_7,
            color: Colors.yellow,
            size: 62,
          ),
          const SizedBox(height: 18),
          Text(
            '$bursts Bursts',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }
}
