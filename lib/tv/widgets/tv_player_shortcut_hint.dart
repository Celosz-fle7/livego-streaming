import 'package:flutter/material.dart';

class TVPlayerShortcutHint
    extends StatelessWidget {
  const TVPlayerShortcutHint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize:
          MainAxisSize.min,
      children: [
        Icon(
          Icons.keyboard,
          color: Colors.white38,
          size: 18,
        ),
        SizedBox(width: 8),
        Text(
          '← → Seek   OK Pause',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
