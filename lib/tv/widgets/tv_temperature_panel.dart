import 'package:flutter/material.dart';

class TVTemperaturePanel
    extends StatelessWidget {
  final double temp;

  const TVTemperaturePanel({
    super.key,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    if (temp >= 55) {
      color = Colors.orange;
    }

    if (temp >= 70) {
      color = Colors.red;
    }

    return Container(
      width: 260,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            Icons.thermostat,
            color: color,
            size: 40,
          ),
          const SizedBox(height: 14),
          Text(
            '${temp.toStringAsFixed(1)}°C',
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
