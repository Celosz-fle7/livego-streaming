import 'package:flutter/material.dart';

class TVSmartPreloadPanel
    extends StatelessWidget {
  final bool enabled;
  final int items;

  const TVSmartPreloadPanel({
    super.key,
    required this.enabled,
    required this.items,
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
          Icon(
            enabled
                ? Icons.bolt
                : Icons.bolt_outlined,
            color: enabled
                ? Colors.orange
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$items Preloaded',
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
