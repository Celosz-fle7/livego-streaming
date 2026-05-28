import 'package:flutter/material.dart';

class TVPlayerToast
    extends StatelessWidget {
  final String text;

  const TVPlayerToast({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
