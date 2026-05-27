import 'package:flutter/material.dart';

class TVAIPanel
    extends StatelessWidget {
  final bool recommendations;
  final bool smartContinue;
  final bool preload;

  const TVAIPanel({
    super.key,
    required this.recommendations,
    required this.smartContinue,
    required this.preload,
  });

  Widget row(
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
                ? Icons.auto_awesome
                : Icons.block,
            color: active
                ? Colors.cyan
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
      width: 340,
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
          row(
            'AI Recommendations',
            recommendations,
          ),
          row(
            'Smart Continue',
            smartContinue,
          ),
          row(
            'Predictive Preload',
            preload,
          ),
        ],
      ),
    );
  }
}
