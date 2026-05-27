import 'package:flutter/material.dart';

class TVAISubtitlePanel
    extends StatelessWidget {
  final bool enabled;
  final String language;

  const TVAISubtitlePanel({
    super.key,
    required this.enabled,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.subtitles
                : Icons.subtitles_off,
            color: enabled
                ? Colors.green
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            language,
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
