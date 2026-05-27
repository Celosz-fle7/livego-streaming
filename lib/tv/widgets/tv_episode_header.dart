import 'package:flutter/material.dart';

class TVEpisodeHeader
    extends StatelessWidget {
  final int total;

  const TVEpisodeHeader({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daftar Episode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$total Episode',
          style: const TextStyle(
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
