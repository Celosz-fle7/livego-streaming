import 'package:flutter/material.dart';

class TVResumeBanner extends StatelessWidget {
  final int episode;
  final int minute;

  const TVResumeBanner({
    super.key,
    required this.episode,
    required this.minute,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 40,
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.history,
              color: Color(0xFF04D2FF),
            ),
            const SizedBox(width: 12),
            Text(
              'Lanjut Eps $episode • ${minute}m',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
