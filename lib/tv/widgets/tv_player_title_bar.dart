import 'package:flutter/material.dart';

class TVPlayerTitleBar
    extends StatelessWidget {
  final String title;

  const TVPlayerTitleBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow:
          TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight:
            FontWeight.bold,
      ),
    );
  }
}
