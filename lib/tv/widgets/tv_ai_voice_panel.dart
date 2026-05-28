import 'package:flutter/material.dart';

class TVAIVoicePanel
    extends StatelessWidget {
  final String command;

  const TVAIVoicePanel({
    super.key,
    required this.command,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.record_voice_over,
            color: Colors.orange,
            size: 44,
          ),
          const SizedBox(height: 16),
          Text(
            command.isEmpty
                ? 'No Command'
                : command,
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
