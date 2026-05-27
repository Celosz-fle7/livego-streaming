import 'package:flutter/material.dart';

class TVDeviceProfilePanel
    extends StatelessWidget {
  final String profile;
  final int ram;

  const TVDeviceProfilePanel({
    super.key,
    required this.profile,
    required this.ram,
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
          const Icon(
            Icons.tv,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            profile,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$ram GB RAM',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
