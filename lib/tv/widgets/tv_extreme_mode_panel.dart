import 'package:flutter/material.dart';

class TVExtremeModePanel
    extends StatelessWidget {
  final bool enabled;

  const TVExtremeModePanel({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.bolt
                : Icons.bolt_outlined,
            color:
                enabled ? Colors.orange : Colors.grey,
            size: 52,
          ),
          const SizedBox(height: 18),
          Text(
            enabled
                ? 'EXTREME MODE'
                : 'NORMAL MODE',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
