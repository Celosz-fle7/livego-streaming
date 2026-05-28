import 'package:flutter/material.dart';

class TVDeviceSafetyPanel extends StatelessWidget {
  final int temperature;
  final int battery;
  final bool safeMode;

  const TVDeviceSafetyPanel({
    super.key,
    required this.temperature,
    required this.battery,
    required this.safeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            safeMode ? Icons.warning_amber : Icons.device_thermostat,
            color: safeMode ? Colors.orange : Colors.green,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            '${temperature}°C',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Battery $battery%',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
