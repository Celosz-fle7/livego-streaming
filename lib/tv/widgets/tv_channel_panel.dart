import 'package:flutter/material.dart';

class TVChannelPanel
    extends StatelessWidget {
  final String channel;

  const TVChannelPanel({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
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
            Icons.live_tv,
            color: Colors.red,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            channel,
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
