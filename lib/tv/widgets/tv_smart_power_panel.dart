import 'package:flutter/material.dart';

class TVSmartPowerPanel
    extends StatelessWidget {
  final bool ecoMode;
  final int brightness;

  const TVSmartPowerPanel({
    super.key,
    required this.ecoMode,
    required this.brightness,
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
            ecoMode
                ? Icons.energy_savings_leaf
                : Icons.flash_on,
            color:
                ecoMode ? Colors.green : Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$brightness% Brightness',
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
