import 'package:flutter/material.dart';

class TVRenderPanel
    extends StatelessWidget {
  final int frames;
  final int dropped;

  const TVRenderPanel({
    super.key,
    required this.frames,
    required this.dropped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            '$frames Frames',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$dropped Dropped',
            style: const TextStyle(
              color: Colors.red,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
