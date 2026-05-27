import 'package:flutter/material.dart';

class TVSeekIndicator
    extends StatelessWidget {
  final bool forward;
  final int seconds;

  const TVSeekIndicator({
    super.key,
    required this.forward,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius:
              BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              forward
                  ? Icons.fast_forward
                  : Icons.fast_rewind,
              color: Colors.white,
              size: 34,
            ),
            const SizedBox(width: 12),
            Text(
              '${seconds}s',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
