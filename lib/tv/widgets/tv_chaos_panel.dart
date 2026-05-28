import 'package:flutter/material.dart';

class TVChaosPanel
    extends StatelessWidget {
  final int storms;

  const TVChaosPanel({
    super.key,
    required this.storms,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.thunderstorm,
            color: Colors.orange,
            size: 68,
          ),
          const SizedBox(height: 20),
          Text(
            '$storms Storms',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 38,
            ),
          ),
        ],
      ),
    );
  }
}
