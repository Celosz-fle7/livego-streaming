import 'package:flutter/material.dart';

class TVReleaseBadge
    extends StatelessWidget {
  final String version;

  const TVReleaseBadge({
    super.key,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        'v$version',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
