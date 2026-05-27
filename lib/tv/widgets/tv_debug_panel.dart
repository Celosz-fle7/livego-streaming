import 'package:flutter/material.dart';

class TVDebugPanel
    extends StatelessWidget {
  final String text;

  const TVDebugPanel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }
}
