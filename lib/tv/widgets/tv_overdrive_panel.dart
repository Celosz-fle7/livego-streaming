import 'package:flutter/material.dart';

class TVOverdrivePanel
    extends StatelessWidget {
  final int speed;

  const TVOverdrivePanel({
    super.key,
    required this.speed,
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
            Icons.rocket,
            color: Colors.green,
            size: 82,
          ),
          const SizedBox(height: 24),
          Text(
            '$speed%',
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
