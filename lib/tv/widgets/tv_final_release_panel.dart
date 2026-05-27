import 'package:flutter/material.dart';

class TVFinalReleasePanel
    extends StatelessWidget {
  final String version;
  final int build;

  const TVFinalReleasePanel({
    super.key,
    required this.version,
    required this.build,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding:
          const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.verified,
            color: Colors.green,
            size: 52,
          ),
          const SizedBox(height: 18),
          const Text(
            'Production Ready',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Version $version ($build)',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
