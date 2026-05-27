import 'package:flutter/material.dart';

class TVCinemaModePanel
    extends StatelessWidget {
  final bool enabled;

  const TVCinemaModePanel({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.movie
                : Icons.movie_outlined,
            color: enabled
                ? Colors.red
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Cinema Mode'
                : 'Normal Mode',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
