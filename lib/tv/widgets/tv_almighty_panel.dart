import 'package:flutter/material.dart';

class TVAlmightyPanel
    extends StatelessWidget {
  final int power;

  const TVAlmightyPanel({
    super.key,
    required this.power,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 480,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Colors.yellow,
            size: 90,
          ),
          const SizedBox(height: 26),
          Text(
            '$power',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 54,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ALMIGHTY SYSTEM',
            style: TextStyle(
              color: Colors.white70,
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
