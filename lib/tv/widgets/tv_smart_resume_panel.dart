import 'package:flutter/material.dart';

class TVSmartResumePanel
    extends StatelessWidget {
  final int resumed;

  const TVSmartResumePanel({
    super.key,
    required this.resumed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.play_arrow,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$resumed Smart Resumes',
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
