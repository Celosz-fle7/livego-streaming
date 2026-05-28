import 'package:flutter/material.dart';

class TVHeroTitle extends StatelessWidget {
  final String title;

  const TVHeroTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 46,
        fontWeight: FontWeight.bold,
        height: 1.1,
      ),
    );
  }
}
