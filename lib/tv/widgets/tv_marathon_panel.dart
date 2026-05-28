import 'package:flutter/material.dart';

class TVMarathonPanel
    extends StatelessWidget {
  final int episodes;

  const TVMarathonPanel({
    super.key,
    required this.episodes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$episodes Episodes',
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
