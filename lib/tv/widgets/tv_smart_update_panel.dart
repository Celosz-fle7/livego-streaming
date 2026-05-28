import 'package:flutter/material.dart';

class TVSmartUpdatePanel
    extends StatelessWidget {
  final String version;

  const TVSmartUpdatePanel({
    super.key,
    required this.version,
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
            Icons.system_update,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            version,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
