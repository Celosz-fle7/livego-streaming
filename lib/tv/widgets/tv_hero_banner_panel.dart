import 'package:flutter/material.dart';

class TVHeroBannerPanel
    extends StatelessWidget {
  final double height;

  const TVHeroBannerPanel({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'Hero ${height.toInt()}px',
          style: const TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
