import 'package:flutter/material.dart';

class TVCacheBadge
    extends StatelessWidget {
  final bool active;

  const TVCacheBadge({
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
            ? Colors.green
            : Colors.white24,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        active ? 'CACHE' : 'NO CACHE',
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
