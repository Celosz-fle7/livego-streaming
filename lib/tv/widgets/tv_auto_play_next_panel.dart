import 'package:flutter/material.dart';

class TVAutoPlayNextPanel
    extends StatelessWidget {
  final bool enabled;
  final int countdown;

  const TVAutoPlayNextPanel({
    super.key,
    required this.enabled,
    required this.countdown,
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
          const Icon(
            Icons.skip_next,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Auto Next ON'
                : 'Auto Next OFF',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$countdown Seconds',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
