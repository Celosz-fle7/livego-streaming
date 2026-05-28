import 'package:flutter/material.dart';

class TVGPUPanel
    extends StatelessWidget {
  final int usage;
  final int temp;

  const TVGPUPanel({
    super.key,
    required this.usage,
    required this.temp,
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
            'GPU $usage%',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$temp°C',
            style: const TextStyle(
              color: Colors.orange,
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
