import 'package:flutter/material.dart';

class TVImagePlaceholder extends StatelessWidget {
  const TVImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF151515),
      child: const Center(
        child: Icon(
          Icons.movie,
          color: Colors.white24,
          size: 42,
        ),
      ),
    );
  }
}
