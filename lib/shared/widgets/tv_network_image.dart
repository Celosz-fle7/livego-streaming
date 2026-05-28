import 'package:flutter/material.dart';

class TVNetworkImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? radius;

  const TVNetworkImage({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          radius ?? BorderRadius.circular(12),
      child: Image.network(
        image,
        width: width,
        height: height,
        fit: fit,
        filterQuality: FilterQuality.low,
        errorBuilder: (_, __, ___) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xFF151515),
            child: const Icon(
              Icons.broken_image,
              color: Colors.white24,
            ),
          );
        },
      ),
    );
  }
}
