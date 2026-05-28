import 'package:flutter/material.dart';

class TVSeekIndicator
    extends StatelessWidget {
  final int seconds;
  final bool forward;

  const TVSeekIndicator({
    super.key,
    required this.seconds,
    required this.forward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            forward
                ? Icons.fast_forward
                : Icons.fast_rewind,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            '${forward ? '+' : '-'}$seconds detik',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
