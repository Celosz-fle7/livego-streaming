import 'package:flutter/material.dart';

class TVImagePolicyPanel extends StatelessWidget {
  final int width;
  final int height;
  final bool fadeIn;

  const TVImagePolicyPanel({
    super.key,
    required this.width,
    required this.height,
    required this.fadeIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.image, color: Colors.cyan, size: 72),
          const SizedBox(height: 20),
          Text(
            '${width}x$height',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            fadeIn ? 'Fade ON' : 'Fade OFF',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
