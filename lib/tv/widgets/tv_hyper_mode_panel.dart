import 'package:flutter/material.dart';

class TVHyperModePanel
    extends StatelessWidget {
  final bool enabled;
  final int boost;

  const TVHyperModePanel({
    super.key,
    required this.enabled,
    required this.boost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
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
                ? Icons.flash_on
                : Icons.flash_off,
            color:
                enabled ? Colors.yellow : Colors.grey,
            size: 54,
          ),
          const SizedBox(height: 18),
          Text(
            '$boost%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }
}
