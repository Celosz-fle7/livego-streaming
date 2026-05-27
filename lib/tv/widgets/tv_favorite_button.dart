import 'package:flutter/material.dart';

class TVFavoriteButton
    extends StatelessWidget {

  final bool active;

  final VoidCallback onTap;

  const TVFavoriteButton({
    super.key,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: onTap,

      icon: Icon(
        active
            ? Icons.favorite
            : Icons.favorite_border,

        color: active
            ? Colors.red
            : Colors.white,
      ),
    );
  }
}
