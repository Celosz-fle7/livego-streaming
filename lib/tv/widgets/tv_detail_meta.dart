import 'package:flutter/material.dart';

class TVDetailMeta extends StatelessWidget {
  final String platform;
  final int episodes;

  const TVDetailMeta({
    super.key,
    required this.platform,
    required this.episodes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius:
                BorderRadius.circular(8),
          ),
          child: Text(
            platform.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$episodes Episode',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
