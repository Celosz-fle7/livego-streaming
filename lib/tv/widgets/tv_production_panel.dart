import 'package:flutter/material.dart';

class TVProductionPanel
    extends StatelessWidget {
  final bool production;
  final bool monitoring;
  final bool reporting;

  const TVProductionPanel({
    super.key,
    required this.production,
    required this.monitoring,
    required this.reporting,
  });

  Widget row(
    String text,
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
            text,
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
      width: 340,
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
            'Production Mode',
            production,
          ),
          row(
            'Monitoring',
            monitoring,
          ),
          row(
            'Reporting',
            reporting,
          ),
        ],
      ),
    );
  }
}
