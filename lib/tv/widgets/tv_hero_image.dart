import 'package:flutter/material.dart';

class TVHeroImage extends StatelessWidget {
  final String image;

  const TVHeroImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        image,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
        loadingBuilder:
            (_, child, progress) {
          if (progress == null) {
            return child;
          }

          return Container(
            color: const Color(0xFF070B12),
          );
        },
        errorBuilder:
            (_, __, ___) {
          return Container(
            color: const Color(0xFF070B12),
          );
        },
      ),
    );
  }
}
