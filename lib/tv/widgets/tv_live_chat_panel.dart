import 'package:flutter/material.dart';

class TVLiveChatPanel
    extends StatelessWidget {
  final int messages;

  const TVLiveChatPanel({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.chat,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$messages Messages',
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
