import 'package:flutter/material.dart';

class TVDetailBackdrop
    extends StatelessWidget {
  final String image;

  const TVDetailBackdrop({
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
        errorBuilder:
            (_, __, ___) {
          return Container(
            color: const Color(
              0xFF070B12,
            ),
          );
        },
      ),
    );
  }
}
