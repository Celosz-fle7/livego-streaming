import 'package:flutter/material.dart';

class TVAPKStatusPanel
    extends StatelessWidget {
  final bool shrink;
  final bool split;

  const TVAPKStatusPanel({
    super.key,
    required this.shrink,
    required this.split,
  });

  Widget _row(
    String text,
    bool active,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(
            active
                ? Icons.check_circle
                : Icons.cancel,
            color: active
                ? Colors.green
                : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'APK Optimization',
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 18),
          _row(
            'Shrink Resources',
            shrink,
          ),
          _row(
            'Split ABI',
            split,
          ),
        ],
      ),
    );
  }
}
