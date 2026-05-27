import 'package:flutter/material.dart';

class TVContinuePanel
    extends StatelessWidget {
  final double progress;

  const TVContinuePanel({
    super.key,
    required this.progress,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Continue Watching',
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 18),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor:
                Colors.white24,
            valueColor:
                const AlwaysStoppedAnimation(
              Color(0xFF04D2FF),
            ),
          ),
        ],
      ),
    );
  }
}
