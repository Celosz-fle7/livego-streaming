import 'package:flutter/material.dart';

class TVEmptyState extends StatelessWidget {
  final String title;

  const TVEmptyState({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.tv_off,
            color: Colors.white24,
            size: 80,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
