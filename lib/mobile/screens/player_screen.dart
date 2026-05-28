import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  final String title;
  final String streamUrl;

  const PlayerScreen({
    super.key,
    required this.title,
    required this.streamUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_circle_fill, color: Colors.white, size: 110),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 12),
            Text(
              streamUrl.isEmpty ? 'No stream source' : streamUrl,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
