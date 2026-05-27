import 'package:flutter/material.dart';

class TVVersionBadge
    extends StatelessWidget {
  final String version;

  const TVVersionBadge({
    super.key,
    required this.version,
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
        color: Colors.deepPurple,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        version,
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
