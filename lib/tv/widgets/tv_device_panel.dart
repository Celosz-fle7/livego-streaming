import 'package:flutter/material.dart';

class TVDevicePanel
    extends StatelessWidget {
  final String model;
  final String version;

  const TVDevicePanel({
    super.key,
    required this.model,
    required this.version,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Text(
            'Device',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            model,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Version $version',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
