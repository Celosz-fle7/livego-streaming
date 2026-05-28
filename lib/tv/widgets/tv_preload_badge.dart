import 'package:flutter/material.dart';

class TVPreloadBadge
    extends StatelessWidget {
  final bool active;

  const TVPreloadBadge({
    super.key,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: active
            ? Colors.cyan
            : Colors.white24,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        active
            ? 'PRELOAD'
            : 'NO PRELOAD',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
