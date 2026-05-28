import 'package:flutter/material.dart';

class TVAppBar extends StatelessWidget {
  final String title;

  const TVAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.live_tv,
            color: Color(0xFF04D2FF),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
