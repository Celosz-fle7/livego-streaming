import 'package:flutter/material.dart';

class TVPhantomPanel
    extends StatelessWidget {
  final bool stealth;
  final int shadows;

  const TVPhantomPanel({
    super.key,
    required this.stealth,
    required this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Icon(
            stealth
                ? Icons.visibility_off
                : Icons.visibility,
            color:
                stealth ? Colors.deepPurple : Colors.grey,
            size: 60,
          ),
          const SizedBox(height: 18),
          Text(
            '$shadows Shadows',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }
}
