import 'package:flutter/material.dart';

class TVGenrePanel
    extends StatelessWidget {
  final String genre;

  const TVGenrePanel({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: Text(
        genre,
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
