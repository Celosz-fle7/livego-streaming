import 'package:flutter/material.dart';

class TVVolumeOverlay
    extends StatelessWidget {
  final double volume;

  const TVVolumeOverlay({
    super.key,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 40,
      top: 100,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.volume_up,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: volume,
              minHeight: 6,
              backgroundColor:
                  Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation(
                Color(0xFF04D2FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
