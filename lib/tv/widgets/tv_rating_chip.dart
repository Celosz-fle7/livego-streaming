import 'package:flutter/material.dart';

class TVRatingChip
    extends StatelessWidget {
  final double rating;

  const TVRatingChip({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFB800),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: Colors.black,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
