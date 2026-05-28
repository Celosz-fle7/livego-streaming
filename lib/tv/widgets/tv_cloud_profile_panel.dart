import 'package:flutter/material.dart';

class TVCloudProfilePanel
    extends StatelessWidget {
  final int profiles;

  const TVCloudProfilePanel({
    super.key,
    required this.profiles,
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
            Icons.cloud,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$profiles Profiles',
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
