import 'package:flutter/material.dart';

class TVEnterprisePanel
    extends StatelessWidget {
  final bool enabled;
  final bool monitoring;
  final bool cache;

  const TVEnterprisePanel({
    super.key,
    required this.enabled,
    required this.monitoring,
    required this.cache,
  });

  Widget item(
    String title,
    bool active,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
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
          item(
            'Enterprise Enabled',
            enabled,
          ),
          item(
            'SLA Monitoring',
            monitoring,
          ),
          item(
            'Distributed Cache',
            cache,
          ),
        ],
      ),
    );
  }
}
