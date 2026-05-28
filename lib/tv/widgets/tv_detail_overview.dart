import 'package:flutter/material.dart';

class TVDetailOverview
    extends StatelessWidget {
  final String text;

  const TVDetailOverview({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
          height: 1.6,
        ),
      ),
    );
  }
}
