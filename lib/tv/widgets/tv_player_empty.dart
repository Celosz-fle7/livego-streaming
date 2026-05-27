import 'package:flutter/material.dart';

class TVPlayerEmpty
    extends StatelessWidget {
  final String text;

  const TVPlayerEmpty({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 20,
        ),
      ),
    );
  }
}
