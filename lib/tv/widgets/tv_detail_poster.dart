import 'package:flutter/material.dart';

class TVDetailPoster
    extends StatelessWidget {
  final String image;

  const TVDetailPoster({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 340,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.45,
            ),
            blurRadius: 24,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(18),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
