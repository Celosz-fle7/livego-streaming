import 'package:flutter/material.dart';

class TVGlobalConfigPanel
    extends StatelessWidget {
  final bool production;
  final bool analytics;
  final bool preload;
  final bool cache;

  const TVGlobalConfigPanel({
    super.key,
    required this.production,
    required this.analytics,
    required this.preload,
    required this.cache,
  });

  Widget row(
    String title,
    bool active,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(
            active
                ? Icons.check_circle
                : Icons.cancel,
            color: active
                ? Colors.green
                : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
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
        children: [
          row(
            'Production',
            production,
          ),
          row(
            'Analytics',
            analytics,
          ),
          row(
            'Preload',
            preload,
          ),
          row(
            'Cache',
            cache,
          ),
        ],
      ),
    );
  }
}
