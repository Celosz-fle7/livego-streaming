import 'package:flutter/material.dart';

class TVMultiAudioPanel
    extends StatelessWidget {
  final String current;

  const TVMultiAudioPanel({
    super.key,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.audiotrack,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            current,
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
